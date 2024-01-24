import{ReplaceError as e,Fragment as t,Slice as r,MarkType as n,Mark as i}from"prosemirror-model";const o=65535;const s=Math.pow(2,16);function makeRecover(e,t){return e+t*s}function recoverIndex(e){return e&o}function recoverOffset(e){return(e-(e&o))/s}const p=1,l=2,a=4,h=8;class MapResult{constructor(e,t,r){this.pos=e;this.delInfo=t;this.recover=r}get deleted(){return(this.delInfo&h)>0}get deletedBefore(){return(this.delInfo&(p|a))>0}get deletedAfter(){return(this.delInfo&(l|a))>0}get deletedAcross(){return(this.delInfo&a)>0}}class StepMap{constructor(e,t=false){this.ranges=e;this.inverted=t;if(!e.length&&StepMap.empty)return StepMap.empty}recover(e){let t=0,r=recoverIndex(e);if(!this.inverted)for(let e=0;e<r;e++)t+=this.ranges[3*e+2]-this.ranges[3*e+1];return this.ranges[3*r]+t+recoverOffset(e)}mapResult(e,t=1){return this._map(e,t,false)}map(e,t=1){return this._map(e,t,true)}_map(e,t,r){let n=0,i=this.inverted?2:1,o=this.inverted?1:2;for(let s=0;s<this.ranges.length;s+=3){let c=this.ranges[s]-(this.inverted?n:0);if(c>e)break;let d=this.ranges[s+i],f=this.ranges[s+o],u=c+d;if(e<=u){let i=d?e==c?-1:e==u?1:t:t;let o=c+n+(i<0?0:f);if(r)return o;let m=e==(t<0?c:u)?null:makeRecover(s/3,e-c);let S=e==c?l:e==u?p:a;(t<0?e!=c:e!=u)&&(S|=h);return new MapResult(o,S,m)}n+=f-d}return r?e+n:new MapResult(e+n,0,null)}touches(e,t){let r=0,n=recoverIndex(t);let i=this.inverted?2:1,o=this.inverted?1:2;for(let t=0;t<this.ranges.length;t+=3){let s=this.ranges[t]-(this.inverted?r:0);if(s>e)break;let p=this.ranges[t+i],l=s+p;if(e<=l&&t==3*n)return true;r+=this.ranges[t+o]-p}return false}forEach(e){let t=this.inverted?2:1,r=this.inverted?1:2;for(let n=0,i=0;n<this.ranges.length;n+=3){let o=this.ranges[n],s=o-(this.inverted?i:0),p=o+(this.inverted?0:i);let l=this.ranges[n+t],a=this.ranges[n+r];e(s,s+l,p,p+a);i+=a-l}}invert(){return new StepMap(this.ranges,!this.inverted)}toString(){return(this.inverted?"-":"")+JSON.stringify(this.ranges)}static offset(e){return 0==e?StepMap.empty:new StepMap(e<0?[0,-e,0]:[0,0,e])}}StepMap.empty=new StepMap([]);class Mapping{constructor(e=[],t,r=0,n=e.length){this.maps=e;this.mirror=t;this.from=r;this.to=n}slice(e=0,t=this.maps.length){return new Mapping(this.maps,this.mirror,e,t)}copy(){return new Mapping(this.maps.slice(),this.mirror&&this.mirror.slice(),this.from,this.to)}appendMap(e,t){this.to=this.maps.push(e);null!=t&&this.setMirror(this.maps.length-1,t)}appendMapping(e){for(let t=0,r=this.maps.length;t<e.maps.length;t++){let n=e.getMirror(t);this.appendMap(e.maps[t],null!=n&&n<t?r+n:void 0)}}getMirror(e){if(this.mirror)for(let t=0;t<this.mirror.length;t++)if(this.mirror[t]==e)return this.mirror[t+(t%2?-1:1)]}setMirror(e,t){this.mirror||(this.mirror=[]);this.mirror.push(e,t)}appendMappingInverted(e){for(let t=e.maps.length-1,r=this.maps.length+e.maps.length;t>=0;t--){let n=e.getMirror(t);this.appendMap(e.maps[t].invert(),null!=n&&n>t?r-n-1:void 0)}}invert(){let e=new Mapping;e.appendMappingInverted(this);return e}map(e,t=1){if(this.mirror)return this._map(e,t,true);for(let r=this.from;r<this.to;r++)e=this.maps[r].map(e,t);return e}mapResult(e,t=1){return this._map(e,t,false)}_map(e,t,r){let n=0;for(let r=this.from;r<this.to;r++){let i=this.maps[r],o=i.mapResult(e,t);if(null!=o.recover){let t=this.getMirror(r);if(null!=t&&t>r&&t<this.to){r=t;e=this.maps[t].recover(o.recover);continue}}n|=o.delInfo;e=o.pos}return r?e:new MapResult(e,n,null)}}const c=Object.create(null);class Step{getMap(){return StepMap.empty}merge(e){return null}static fromJSON(e,t){if(!t||!t.stepType)throw new RangeError("Invalid input for Step.fromJSON");let r=c[t.stepType];if(!r)throw new RangeError(`No step type ${t.stepType} defined`);return r.fromJSON(e,t)}static jsonID(e,t){if(e in c)throw new RangeError("Duplicate use of step JSON ID "+e);c[e]=t;t.prototype.jsonID=e;return t}}class StepResult{constructor(e,t){this.doc=e;this.failed=t}static ok(e){return new StepResult(e,null)}static fail(e){return new StepResult(null,e)}static fromReplace(t,r,n,i){try{return StepResult.ok(t.replace(r,n,i))}catch(t){if(t instanceof e)return StepResult.fail(t.message);throw t}}}function mapFragment(e,r,n){let i=[];for(let t=0;t<e.childCount;t++){let o=e.child(t);o.content.size&&(o=o.copy(mapFragment(o.content,r,o)));o.isInline&&(o=r(o,n,t));i.push(o)}return t.fromArray(i)}class AddMarkStep extends Step{constructor(e,t,r){super();this.from=e;this.to=t;this.mark=r}apply(e){let t=e.slice(this.from,this.to),n=e.resolve(this.from);let i=n.node(n.sharedDepth(this.to));let o=new r(mapFragment(t.content,((e,t)=>e.isAtom&&t.type.allowsMarkType(this.mark.type)?e.mark(this.mark.addToSet(e.marks)):e),i),t.openStart,t.openEnd);return StepResult.fromReplace(e,this.from,this.to,o)}invert(){return new RemoveMarkStep(this.from,this.to,this.mark)}map(e){let t=e.mapResult(this.from,1),r=e.mapResult(this.to,-1);return t.deleted&&r.deleted||t.pos>=r.pos?null:new AddMarkStep(t.pos,r.pos,this.mark)}merge(e){return e instanceof AddMarkStep&&e.mark.eq(this.mark)&&this.from<=e.to&&this.to>=e.from?new AddMarkStep(Math.min(this.from,e.from),Math.max(this.to,e.to),this.mark):null}toJSON(){return{stepType:"addMark",mark:this.mark.toJSON(),from:this.from,to:this.to}}static fromJSON(e,t){if("number"!=typeof t.from||"number"!=typeof t.to)throw new RangeError("Invalid input for AddMarkStep.fromJSON");return new AddMarkStep(t.from,t.to,e.markFromJSON(t.mark))}}Step.jsonID("addMark",AddMarkStep);class RemoveMarkStep extends Step{constructor(e,t,r){super();this.from=e;this.to=t;this.mark=r}apply(e){let t=e.slice(this.from,this.to);let n=new r(mapFragment(t.content,(e=>e.mark(this.mark.removeFromSet(e.marks))),e),t.openStart,t.openEnd);return StepResult.fromReplace(e,this.from,this.to,n)}invert(){return new AddMarkStep(this.from,this.to,this.mark)}map(e){let t=e.mapResult(this.from,1),r=e.mapResult(this.to,-1);return t.deleted&&r.deleted||t.pos>=r.pos?null:new RemoveMarkStep(t.pos,r.pos,this.mark)}merge(e){return e instanceof RemoveMarkStep&&e.mark.eq(this.mark)&&this.from<=e.to&&this.to>=e.from?new RemoveMarkStep(Math.min(this.from,e.from),Math.max(this.to,e.to),this.mark):null}toJSON(){return{stepType:"removeMark",mark:this.mark.toJSON(),from:this.from,to:this.to}}static fromJSON(e,t){if("number"!=typeof t.from||"number"!=typeof t.to)throw new RangeError("Invalid input for RemoveMarkStep.fromJSON");return new RemoveMarkStep(t.from,t.to,e.markFromJSON(t.mark))}}Step.jsonID("removeMark",RemoveMarkStep);class AddNodeMarkStep extends Step{constructor(e,t){super();this.pos=e;this.mark=t}apply(e){let n=e.nodeAt(this.pos);if(!n)return StepResult.fail("No node at mark step's position");let i=n.type.create(n.attrs,null,this.mark.addToSet(n.marks));return StepResult.fromReplace(e,this.pos,this.pos+1,new r(t.from(i),0,n.isLeaf?0:1))}invert(e){let t=e.nodeAt(this.pos);if(t){let e=this.mark.addToSet(t.marks);if(e.length==t.marks.length){for(let r=0;r<t.marks.length;r++)if(!t.marks[r].isInSet(e))return new AddNodeMarkStep(this.pos,t.marks[r]);return new AddNodeMarkStep(this.pos,this.mark)}}return new RemoveNodeMarkStep(this.pos,this.mark)}map(e){let t=e.mapResult(this.pos,1);return t.deletedAfter?null:new AddNodeMarkStep(t.pos,this.mark)}toJSON(){return{stepType:"addNodeMark",pos:this.pos,mark:this.mark.toJSON()}}static fromJSON(e,t){if("number"!=typeof t.pos)throw new RangeError("Invalid input for AddNodeMarkStep.fromJSON");return new AddNodeMarkStep(t.pos,e.markFromJSON(t.mark))}}Step.jsonID("addNodeMark",AddNodeMarkStep);class RemoveNodeMarkStep extends Step{constructor(e,t){super();this.pos=e;this.mark=t}apply(e){let n=e.nodeAt(this.pos);if(!n)return StepResult.fail("No node at mark step's position");let i=n.type.create(n.attrs,null,this.mark.removeFromSet(n.marks));return StepResult.fromReplace(e,this.pos,this.pos+1,new r(t.from(i),0,n.isLeaf?0:1))}invert(e){let t=e.nodeAt(this.pos);return t&&this.mark.isInSet(t.marks)?new AddNodeMarkStep(this.pos,this.mark):this}map(e){let t=e.mapResult(this.pos,1);return t.deletedAfter?null:new RemoveNodeMarkStep(t.pos,this.mark)}toJSON(){return{stepType:"removeNodeMark",pos:this.pos,mark:this.mark.toJSON()}}static fromJSON(e,t){if("number"!=typeof t.pos)throw new RangeError("Invalid input for RemoveNodeMarkStep.fromJSON");return new RemoveNodeMarkStep(t.pos,e.markFromJSON(t.mark))}}Step.jsonID("removeNodeMark",RemoveNodeMarkStep);class ReplaceStep extends Step{constructor(e,t,r,n=false){super();this.from=e;this.to=t;this.slice=r;this.structure=n}apply(e){return this.structure&&contentBetween(e,this.from,this.to)?StepResult.fail("Structure replace would overwrite content"):StepResult.fromReplace(e,this.from,this.to,this.slice)}getMap(){return new StepMap([this.from,this.to-this.from,this.slice.size])}invert(e){return new ReplaceStep(this.from,this.from+this.slice.size,e.slice(this.from,this.to))}map(e){let t=e.mapResult(this.from,1),r=e.mapResult(this.to,-1);return t.deletedAcross&&r.deletedAcross?null:new ReplaceStep(t.pos,Math.max(t.pos,r.pos),this.slice)}merge(e){if(!(e instanceof ReplaceStep)||e.structure||this.structure)return null;if(this.from+this.slice.size!=e.from||this.slice.openEnd||e.slice.openStart){if(e.to!=this.from||this.slice.openStart||e.slice.openEnd)return null;{let t=this.slice.size+e.slice.size==0?r.empty:new r(e.slice.content.append(this.slice.content),e.slice.openStart,this.slice.openEnd);return new ReplaceStep(e.from,this.to,t,this.structure)}}{let t=this.slice.size+e.slice.size==0?r.empty:new r(this.slice.content.append(e.slice.content),this.slice.openStart,e.slice.openEnd);return new ReplaceStep(this.from,this.to+(e.to-e.from),t,this.structure)}}toJSON(){let e={stepType:"replace",from:this.from,to:this.to};this.slice.size&&(e.slice=this.slice.toJSON());this.structure&&(e.structure=true);return e}static fromJSON(e,t){if("number"!=typeof t.from||"number"!=typeof t.to)throw new RangeError("Invalid input for ReplaceStep.fromJSON");return new ReplaceStep(t.from,t.to,r.fromJSON(e,t.slice),!!t.structure)}}Step.jsonID("replace",ReplaceStep);class ReplaceAroundStep extends Step{constructor(e,t,r,n,i,o,s=false){super();this.from=e;this.to=t;this.gapFrom=r;this.gapTo=n;this.slice=i;this.insert=o;this.structure=s}apply(e){if(this.structure&&(contentBetween(e,this.from,this.gapFrom)||contentBetween(e,this.gapTo,this.to)))return StepResult.fail("Structure gap-replace would overwrite content");let t=e.slice(this.gapFrom,this.gapTo);if(t.openStart||t.openEnd)return StepResult.fail("Gap is not a flat range");let r=this.slice.insertAt(this.insert,t.content);return r?StepResult.fromReplace(e,this.from,this.to,r):StepResult.fail("Content does not fit in gap")}getMap(){return new StepMap([this.from,this.gapFrom-this.from,this.insert,this.gapTo,this.to-this.gapTo,this.slice.size-this.insert])}invert(e){let t=this.gapTo-this.gapFrom;return new ReplaceAroundStep(this.from,this.from+this.slice.size+t,this.from+this.insert,this.from+this.insert+t,e.slice(this.from,this.to).removeBetween(this.gapFrom-this.from,this.gapTo-this.from),this.gapFrom-this.from,this.structure)}map(e){let t=e.mapResult(this.from,1),r=e.mapResult(this.to,-1);let n=e.map(this.gapFrom,-1),i=e.map(this.gapTo,1);return t.deletedAcross&&r.deletedAcross||n<t.pos||i>r.pos?null:new ReplaceAroundStep(t.pos,r.pos,n,i,this.slice,this.insert,this.structure)}toJSON(){let e={stepType:"replaceAround",from:this.from,to:this.to,gapFrom:this.gapFrom,gapTo:this.gapTo,insert:this.insert};this.slice.size&&(e.slice=this.slice.toJSON());this.structure&&(e.structure=true);return e}static fromJSON(e,t){if("number"!=typeof t.from||"number"!=typeof t.to||"number"!=typeof t.gapFrom||"number"!=typeof t.gapTo||"number"!=typeof t.insert)throw new RangeError("Invalid input for ReplaceAroundStep.fromJSON");return new ReplaceAroundStep(t.from,t.to,t.gapFrom,t.gapTo,r.fromJSON(e,t.slice),t.insert,!!t.structure)}}Step.jsonID("replaceAround",ReplaceAroundStep);function contentBetween(e,t,r){let n=e.resolve(t),i=r-t,o=n.depth;while(i>0&&o>0&&n.indexAfter(o)==n.node(o).childCount){o--;i--}if(i>0){let e=n.node(o).maybeChild(n.indexAfter(o));while(i>0){if(!e||e.isLeaf)return true;e=e.firstChild;i--}}return false}function addMark(e,t,r,n){let i=[],o=[];let s,p;e.doc.nodesBetween(t,r,((e,l,a)=>{if(!e.isInline)return;let h=e.marks;if(!n.isInSet(h)&&a.type.allowsMarkType(n.type)){let a=Math.max(l,t),c=Math.min(l+e.nodeSize,r);let d=n.addToSet(h);for(let e=0;e<h.length;e++)h[e].isInSet(d)||(s&&s.to==a&&s.mark.eq(h[e])?s.to=c:i.push(s=new RemoveMarkStep(a,c,h[e])));p&&p.to==a?p.to=c:o.push(p=new AddMarkStep(a,c,n))}}));i.forEach((t=>e.step(t)));o.forEach((t=>e.step(t)))}function removeMark(e,t,r,i){let o=[],s=0;e.doc.nodesBetween(t,r,((e,p)=>{if(!e.isInline)return;s++;let l=null;if(i instanceof n){let t,r=e.marks;while(t=i.isInSet(r)){(l||(l=[])).push(t);r=t.removeFromSet(r)}}else i?i.isInSet(e.marks)&&(l=[i]):l=e.marks;if(l&&l.length){let n=Math.min(p+e.nodeSize,r);for(let e=0;e<l.length;e++){let r,i=l[e];for(let e=0;e<o.length;e++){let t=o[e];t.step==s-1&&i.eq(o[e].style)&&(r=t)}if(r){r.to=n;r.step=s}else o.push({style:i,from:Math.max(p,t),to:n,step:s})}}}));o.forEach((t=>e.step(new RemoveMarkStep(t.from,t.to,t.style))))}function clearIncompatible(e,n,i,o=i.contentMatch){let s=e.doc.nodeAt(n);let p=[],l=n+1;for(let n=0;n<s.childCount;n++){let a=s.child(n),h=l+a.nodeSize;let c=o.matchType(a.type);if(c){o=c;for(let t=0;t<a.marks.length;t++)i.allowsMarkType(a.marks[t].type)||e.step(new RemoveMarkStep(l,h,a.marks[t]));if(a.isText&&!i.spec.code){let e,n,o=/\r?\n|\r/g;while(e=o.exec(a.text)){n||(n=new r(t.from(i.schema.text(" ",i.allowedMarks(a.marks))),0,0));p.push(new ReplaceStep(l+e.index,l+e.index+e[0].length,n))}}}else p.push(new ReplaceStep(l,h,r.empty));l=h}if(!o.validEnd){let n=o.fillBefore(t.empty,true);e.replace(l,l,new r(n,0,0))}for(let t=p.length-1;t>=0;t--)e.step(p[t])}function canCut(e,t,r){return(0==t||e.canReplace(t,e.childCount))&&(r==e.childCount||e.canReplace(0,r))}function liftTarget(e){let t=e.parent;let r=t.content.cutByIndex(e.startIndex,e.endIndex);for(let t=e.depth;;--t){let n=e.$from.node(t);let i=e.$from.index(t),o=e.$to.indexAfter(t);if(t<e.depth&&n.canReplace(i,o,r))return t;if(0==t||n.type.spec.isolating||!canCut(n,i,o))break}return null}function lift(e,n,i){let{$from:o,$to:s,depth:p}=n;let l=o.before(p+1),a=s.after(p+1);let h=l,c=a;let d=t.empty,f=0;for(let e=p,r=false;e>i;e--)if(r||o.index(e)>0){r=true;d=t.from(o.node(e).copy(d));f++}else h--;let u=t.empty,m=0;for(let e=p,r=false;e>i;e--)if(r||s.after(e+1)<s.end(e)){r=true;u=t.from(s.node(e).copy(u));m++}else c++;e.step(new ReplaceAroundStep(h,c,l,a,new r(d.append(u),f,m),d.size-f,true))}function findWrapping(e,t,r=null,n=e){let i=findWrappingOutside(e,t);let o=i&&findWrappingInside(n,t);return o?i.map(withAttrs).concat({type:t,attrs:r}).concat(o.map(withAttrs)):null}function withAttrs(e){return{type:e,attrs:null}}function findWrappingOutside(e,t){let{parent:r,startIndex:n,endIndex:i}=e;let o=r.contentMatchAt(n).findWrapping(t);if(!o)return null;let s=o.length?o[0]:t;return r.canReplaceWith(n,i,s)?o:null}function findWrappingInside(e,t){let{parent:r,startIndex:n,endIndex:i}=e;let o=r.child(n);let s=t.contentMatch.findWrapping(o.type);if(!s)return null;let p=s.length?s[s.length-1]:t;let l=p.contentMatch;for(let e=n;l&&e<i;e++)l=l.matchType(r.child(e).type);return l&&l.validEnd?s:null}function wrap(e,n,i){let o=t.empty;for(let e=i.length-1;e>=0;e--){if(o.size){let t=i[e].type.contentMatch.matchFragment(o);if(!t||!t.validEnd)throw new RangeError("Wrapper type given to Transform.wrap does not form valid content of its parent wrapper")}o=t.from(i[e].type.create(i[e].attrs,o))}let s=n.start,p=n.end;e.step(new ReplaceAroundStep(s,p,s,p,new r(o,0,0),i.length,true))}function setBlockType(e,n,i,o,s){if(!o.isTextblock)throw new RangeError("Type given to setBlockType should be a textblock");let p=e.steps.length;e.doc.nodesBetween(n,i,((n,i)=>{if(n.isTextblock&&!n.hasMarkup(o,s)&&canChangeType(e.doc,e.mapping.slice(p).map(i),o)){e.clearIncompatible(e.mapping.slice(p).map(i,1),o);let l=e.mapping.slice(p);let a=l.map(i,1),h=l.map(i+n.nodeSize,1);e.step(new ReplaceAroundStep(a,h,a+1,h-1,new r(t.from(o.create(s,null,n.marks)),0,0),1,true));return false}}))}function canChangeType(e,t,r){let n=e.resolve(t),i=n.index();return n.parent.canReplaceWith(i,i+1,r)}function setNodeMarkup(e,n,i,o,s){let p=e.doc.nodeAt(n);if(!p)throw new RangeError("No node at given position");i||(i=p.type);let l=i.create(o,null,s||p.marks);if(p.isLeaf)return e.replaceWith(n,n+p.nodeSize,l);if(!i.validContent(p.content))throw new RangeError("Invalid content for node type "+i.name);e.step(new ReplaceAroundStep(n,n+p.nodeSize,n+1,n+p.nodeSize-1,new r(t.from(l),0,0),1,true))}function canSplit(e,t,r=1,n){let i=e.resolve(t),o=i.depth-r;let s=n&&n[n.length-1]||i.parent;if(o<0||i.parent.type.spec.isolating||!i.parent.canReplace(i.index(),i.parent.childCount)||!s.type.validContent(i.parent.content.cutByIndex(i.index(),i.parent.childCount)))return false;for(let e=i.depth-1,t=r-2;e>o;e--,t--){let r=i.node(e),o=i.index(e);if(r.type.spec.isolating)return false;let s=r.content.cutByIndex(o,r.childCount);let p=n&&n[t+1];p&&(s=s.replaceChild(0,p.type.create(p.attrs)));let l=n&&n[t]||r;if(!r.canReplace(o+1,r.childCount)||!l.type.validContent(s))return false}let p=i.indexAfter(o);let l=n&&n[0];return i.node(o).canReplaceWith(p,p,l?l.type:i.node(o+1).type)}function split(e,n,i=1,o){let s=e.doc.resolve(n),p=t.empty,l=t.empty;for(let e=s.depth,r=s.depth-i,n=i-1;e>r;e--,n--){p=t.from(s.node(e).copy(p));let r=o&&o[n];l=t.from(r?r.type.create(r.attrs,l):s.node(e).copy(l))}e.step(new ReplaceStep(n,n,new r(p.append(l),i,i),true))}function canJoin(e,t){let r=e.resolve(t),n=r.index();return joinable(r.nodeBefore,r.nodeAfter)&&r.parent.canReplace(n,n+1)}function joinable(e,t){return!!(e&&t&&!e.isLeaf&&e.canAppend(t))}function joinPoint(e,t,r=-1){let n=e.resolve(t);for(let e=n.depth;;e--){let i,o,s=n.index(e);if(e==n.depth){i=n.nodeBefore;o=n.nodeAfter}else if(r>0){i=n.node(e+1);s++;o=n.node(e).maybeChild(s)}else{i=n.node(e).maybeChild(s-1);o=n.node(e+1)}if(i&&!i.isTextblock&&joinable(i,o)&&n.node(e).canReplace(s,s+1))return t;if(0==e)break;t=r<0?n.before(e):n.after(e)}}function join(e,t,n){let i=new ReplaceStep(t-n,t+n,r.empty,true);e.step(i)}function insertPoint(e,t,r){let n=e.resolve(t);if(n.parent.canReplaceWith(n.index(),n.index(),r))return t;if(0==n.parentOffset)for(let e=n.depth-1;e>=0;e--){let t=n.index(e);if(n.node(e).canReplaceWith(t,t,r))return n.before(e+1);if(t>0)return null}if(n.parentOffset==n.parent.content.size)for(let e=n.depth-1;e>=0;e--){let t=n.indexAfter(e);if(n.node(e).canReplaceWith(t,t,r))return n.after(e+1);if(t<n.node(e).childCount)return null}return null}function dropPoint(e,t,r){let n=e.resolve(t);if(!r.content.size)return t;let i=r.content;for(let e=0;e<r.openStart;e++)i=i.firstChild.content;for(let e=1;e<=(0==r.openStart&&r.size?2:1);e++)for(let t=n.depth;t>=0;t--){let r=t==n.depth?0:n.pos<=(n.start(t+1)+n.end(t+1))/2?-1:1;let o=n.index(t)+(r>0?1:0);let s=n.node(t),p=false;if(1==e)p=s.canReplace(o,o,i);else{let e=s.contentMatchAt(o).findWrapping(i.firstChild.type);p=e&&s.canReplaceWith(o,o,e[0])}if(p)return 0==r?n.pos:r<0?n.before(t+1):n.after(t+1)}return null}function replaceStep(e,t,n=t,i=r.empty){if(t==n&&!i.size)return null;let o=e.resolve(t),s=e.resolve(n);return fitsTrivially(o,s,i)?new ReplaceStep(t,n,i):new Fitter(o,s,i).fit()}function fitsTrivially(e,t,r){return!r.openStart&&!r.openEnd&&e.start()==t.start()&&e.parent.canReplace(e.index(),t.index(),r.content)}class Fitter{constructor(e,r,n){this.$from=e;this.$to=r;this.unplaced=n;this.frontier=[];this.placed=t.empty;for(let t=0;t<=e.depth;t++){let r=e.node(t);this.frontier.push({type:r.type,match:r.contentMatchAt(e.indexAfter(t))})}for(let r=e.depth;r>0;r--)this.placed=t.from(e.node(r).copy(this.placed))}get depth(){return this.frontier.length-1}fit(){while(this.unplaced.size){let e=this.findFittable();e?this.placeNodes(e):this.openMore()||this.dropNode()}let e=this.mustMoveInline(),t=this.placed.size-this.depth-this.$from.depth;let n=this.$from,i=this.close(e<0?this.$to:n.doc.resolve(e));if(!i)return null;let o=this.placed,s=n.depth,p=i.depth;while(s&&p&&1==o.childCount){o=o.firstChild.content;s--;p--}let l=new r(o,s,p);return e>-1?new ReplaceAroundStep(n.pos,e,this.$to.pos,this.$to.end(),l,t):l.size||n.pos!=this.$to.pos?new ReplaceStep(n.pos,i.pos,l):null}findFittable(){let e=this.unplaced.openStart;for(let t=this.unplaced.content,r=0,n=this.unplaced.openEnd;r<e;r++){let i=t.firstChild;t.childCount>1&&(n=0);if(i.type.spec.isolating&&n<=r){e=r;break}t=i.content}for(let r=1;r<=2;r++)for(let n=1==r?e:this.unplaced.openStart;n>=0;n--){let e,i=null;if(n){i=contentAt(this.unplaced.content,n-1).firstChild;e=i.content}else e=this.unplaced.content;let o=e.firstChild;for(let e=this.depth;e>=0;e--){let s,{type:p,match:l}=this.frontier[e],a=null;if(1==r&&(o?l.matchType(o.type)||(a=l.fillBefore(t.from(o),false)):i&&p.compatibleContent(i.type)))return{sliceDepth:n,frontierDepth:e,parent:i,inject:a};if(2==r&&o&&(s=l.findWrapping(o.type)))return{sliceDepth:n,frontierDepth:e,parent:i,wrap:s};if(i&&l.matchType(i.type))break}}}openMore(){let{content:e,openStart:t,openEnd:n}=this.unplaced;let i=contentAt(e,t);if(!i.childCount||i.firstChild.isLeaf)return false;this.unplaced=new r(e,t+1,Math.max(n,i.size+t>=e.size-n?t+1:0));return true}dropNode(){let{content:e,openStart:t,openEnd:n}=this.unplaced;let i=contentAt(e,t);if(i.childCount<=1&&t>0){let o=e.size-t<=t+i.size;this.unplaced=new r(dropFromFragment(e,t-1,1),t-1,o?t-1:n)}else this.unplaced=new r(dropFromFragment(e,t,1),t,n)}placeNodes({sliceDepth:e,frontierDepth:n,parent:i,inject:o,wrap:s}){while(this.depth>n)this.closeFrontierNode();if(s)for(let e=0;e<s.length;e++)this.openFrontierNode(s[e]);let p=this.unplaced,l=i?i.content:p.content;let a=p.openStart-e;let h=0,c=[];let{match:d,type:f}=this.frontier[n];if(o){for(let e=0;e<o.childCount;e++)c.push(o.child(e));d=d.matchFragment(o)}let u=l.size+e-(p.content.size-p.openEnd);while(h<l.childCount){let e=l.child(h),t=d.matchType(e.type);if(!t)break;h++;if(h>1||0==a||e.content.size){d=t;c.push(closeNodeStart(e.mark(f.allowedMarks(e.marks)),1==h?a:0,h==l.childCount?u:-1))}}let m=h==l.childCount;m||(u=-1);this.placed=addToFragment(this.placed,n,t.from(c));this.frontier[n].match=d;m&&u<0&&i&&i.type==this.frontier[this.depth].type&&this.frontier.length>1&&this.closeFrontierNode();for(let e=0,t=l;e<u;e++){let e=t.lastChild;this.frontier.push({type:e.type,match:e.contentMatchAt(e.childCount)});t=e.content}this.unplaced=m?0==e?r.empty:new r(dropFromFragment(p.content,e-1,1),e-1,u<0?p.openEnd:e-1):new r(dropFromFragment(p.content,e,h),p.openStart,p.openEnd)}mustMoveInline(){if(!this.$to.parent.isTextblock)return-1;let e,t=this.frontier[this.depth];if(!t.type.isTextblock||!contentAfterFits(this.$to,this.$to.depth,t.type,t.match,false)||this.$to.depth==this.depth&&(e=this.findCloseLevel(this.$to))&&e.depth==this.depth)return-1;let{depth:r}=this.$to,n=this.$to.after(r);while(r>1&&n==this.$to.end(--r))++n;return n}findCloseLevel(e){e:for(let t=Math.min(this.depth,e.depth);t>=0;t--){let{match:r,type:n}=this.frontier[t];let i=t<e.depth&&e.end(t+1)==e.pos+(e.depth-(t+1));let o=contentAfterFits(e,t,n,r,i);if(o){for(let r=t-1;r>=0;r--){let{match:t,type:n}=this.frontier[r];let i=contentAfterFits(e,r,n,t,true);if(!i||i.childCount)continue e}return{depth:t,fit:o,move:i?e.doc.resolve(e.after(t+1)):e}}}}close(e){let t=this.findCloseLevel(e);if(!t)return null;while(this.depth>t.depth)this.closeFrontierNode();t.fit.childCount&&(this.placed=addToFragment(this.placed,t.depth,t.fit));e=t.move;for(let r=t.depth+1;r<=e.depth;r++){let t=e.node(r),n=t.type.contentMatch.fillBefore(t.content,true,e.index(r));this.openFrontierNode(t.type,t.attrs,n)}return e}openFrontierNode(e,r=null,n){let i=this.frontier[this.depth];i.match=i.match.matchType(e);this.placed=addToFragment(this.placed,this.depth,t.from(e.create(r,n)));this.frontier.push({type:e,match:e.contentMatch})}closeFrontierNode(){let e=this.frontier.pop();let r=e.match.fillBefore(t.empty,true);r.childCount&&(this.placed=addToFragment(this.placed,this.frontier.length,r))}}function dropFromFragment(e,t,r){return 0==t?e.cutByIndex(r,e.childCount):e.replaceChild(0,e.firstChild.copy(dropFromFragment(e.firstChild.content,t-1,r)))}function addToFragment(e,t,r){return 0==t?e.append(r):e.replaceChild(e.childCount-1,e.lastChild.copy(addToFragment(e.lastChild.content,t-1,r)))}function contentAt(e,t){for(let r=0;r<t;r++)e=e.firstChild.content;return e}function closeNodeStart(e,r,n){if(r<=0)return e;let i=e.content;r>1&&(i=i.replaceChild(0,closeNodeStart(i.firstChild,r-1,1==i.childCount?n-1:0)));if(r>0){i=e.type.contentMatch.fillBefore(i).append(i);n<=0&&(i=i.append(e.type.contentMatch.matchFragment(i).fillBefore(t.empty,true)))}return e.copy(i)}function contentAfterFits(e,t,r,n,i){let o=e.node(t),s=i?e.indexAfter(t):e.index(t);if(s==o.childCount&&!r.compatibleContent(o.type))return null;let p=n.fillBefore(o.content,true,s);return p&&!invalidMarks(r,o.content,s)?p:null}function invalidMarks(e,t,r){for(let n=r;n<t.childCount;n++)if(!e.allowsMarks(t.child(n).marks))return true;return false}function definesContent(e){return e.spec.defining||e.spec.definingForContent}function replaceRange(e,t,n,i){if(!i.size)return e.deleteRange(t,n);let o=e.doc.resolve(t),s=e.doc.resolve(n);if(fitsTrivially(o,s,i))return e.step(new ReplaceStep(t,n,i));let p=coveredDepths(o,e.doc.resolve(n));0==p[p.length-1]&&p.pop();let l=-(o.depth+1);p.unshift(l);for(let e=o.depth,t=o.pos-1;e>0;e--,t--){let r=o.node(e).type.spec;if(r.defining||r.definingAsContext||r.isolating)break;p.indexOf(e)>-1?l=e:o.before(e)==t&&p.splice(1,0,-e)}let a=p.indexOf(l);let h=[],c=i.openStart;for(let e=i.content,t=0;;t++){let r=e.firstChild;h.push(r);if(t==i.openStart)break;e=r.content}for(let e=c-1;e>=0;e--){let t=h[e],r=definesContent(t.type);if(r&&!t.sameMarkup(o.node(Math.abs(l)-1)))c=e;else if(r||!t.type.isTextblock)break}for(let t=i.openStart;t>=0;t--){let l=(t+c+1)%(i.openStart+1);let d=h[l];if(d)for(let t=0;t<p.length;t++){let h=p[(t+a)%p.length],c=true;if(h<0){c=false;h=-h}let f=o.node(h-1),u=o.index(h-1);if(f.canReplaceWith(u,u,d.type,d.marks))return e.replace(o.before(h),c?s.after(h):n,new r(closeFragment(i.content,0,i.openStart,l),l,i.openEnd))}}let d=e.steps.length;for(let r=p.length-1;r>=0;r--){e.replace(t,n,i);if(e.steps.length>d)break;let l=p[r];if(!(l<0)){t=o.before(l);n=s.after(l)}}}function closeFragment(e,r,n,i,o){if(r<n){let t=e.firstChild;e=e.replaceChild(0,t.copy(closeFragment(t.content,r+1,n,i,t)))}if(r>i){let r=o.contentMatchAt(0);let n=r.fillBefore(e).append(e);e=n.append(r.matchFragment(n).fillBefore(t.empty,true))}return e}function replaceRangeWith(e,n,i,o){if(!o.isInline&&n==i&&e.doc.resolve(n).parent.content.size){let t=insertPoint(e.doc,n,o.type);null!=t&&(n=i=t)}e.replaceRange(n,i,new r(t.from(o),0,0))}function deleteRange(e,t,r){let n=e.doc.resolve(t),i=e.doc.resolve(r);let o=coveredDepths(n,i);for(let t=0;t<o.length;t++){let r=o[t],s=t==o.length-1;if(s&&0==r||n.node(r).type.contentMatch.validEnd)return e.delete(n.start(r),i.end(r));if(r>0&&(s||n.node(r-1).canReplace(n.index(r-1),i.indexAfter(r-1))))return e.delete(n.before(r),i.after(r))}for(let o=1;o<=n.depth&&o<=i.depth;o++)if(t-n.start(o)==n.depth-o&&r>n.end(o)&&i.end(o)-r!=i.depth-o)return e.delete(n.before(o),r);e.delete(t,r)}function coveredDepths(e,t){let r=[],n=Math.min(e.depth,t.depth);for(let i=n;i>=0;i--){let n=e.start(i);if(n<e.pos-(e.depth-i)||t.end(i)>t.pos+(t.depth-i)||e.node(i).type.spec.isolating||t.node(i).type.spec.isolating)break;(n==t.start(i)||i==e.depth&&i==t.depth&&e.parent.inlineContent&&t.parent.inlineContent&&i&&t.start(i-1)==n-1)&&r.push(i)}return r}class AttrStep extends Step{constructor(e,t,r){super();this.pos=e;this.attr=t;this.value=r}apply(e){let n=e.nodeAt(this.pos);if(!n)return StepResult.fail("No node at attribute step's position");let i=Object.create(null);for(let e in n.attrs)i[e]=n.attrs[e];i[this.attr]=this.value;let o=n.type.create(i,null,n.marks);return StepResult.fromReplace(e,this.pos,this.pos+1,new r(t.from(o),0,n.isLeaf?0:1))}getMap(){return StepMap.empty}invert(e){return new AttrStep(this.pos,this.attr,e.nodeAt(this.pos).attrs[this.attr])}map(e){let t=e.mapResult(this.pos,1);return t.deletedAfter?null:new AttrStep(t.pos,this.attr,this.value)}toJSON(){return{stepType:"attr",pos:this.pos,attr:this.attr,value:this.value}}static fromJSON(e,t){if("number"!=typeof t.pos||"string"!=typeof t.attr)throw new RangeError("Invalid input for AttrStep.fromJSON");return new AttrStep(t.pos,t.attr,t.value)}}Step.jsonID("attr",AttrStep);class DocAttrStep extends Step{constructor(e,t){super();this.attr=e;this.value=t}apply(e){let t=Object.create(null);for(let r in e.attrs)t[r]=e.attrs[r];t[this.attr]=this.value;let r=e.type.create(t,e.content,e.marks);return StepResult.ok(r)}getMap(){return StepMap.empty}invert(e){return new DocAttrStep(this.attr,e.attrs[this.attr])}map(e){return this}toJSON(){return{stepType:"docAttr",attr:this.attr,value:this.value}}static fromJSON(e,t){if("string"!=typeof t.attr)throw new RangeError("Invalid input for DocAttrStep.fromJSON");return new DocAttrStep(t.attr,t.value)}}Step.jsonID("docAttr",DocAttrStep);let d=class extends Error{};d=function TransformError(e){let t=Error.call(this,e);t.__proto__=TransformError.prototype;return t};d.prototype=Object.create(Error.prototype);d.prototype.constructor=d;d.prototype.name="TransformError";class Transform{constructor(e){this.doc=e;this.steps=[];this.docs=[];this.mapping=new Mapping}get before(){return this.docs.length?this.docs[0]:this.doc}step(e){let t=this.maybeStep(e);if(t.failed)throw new d(t.failed);return this}maybeStep(e){let t=e.apply(this.doc);t.failed||this.addStep(e,t.doc);return t}get docChanged(){return this.steps.length>0}addStep(e,t){this.docs.push(this.doc);this.steps.push(e);this.mapping.appendMap(e.getMap());this.doc=t}replace(e,t=e,n=r.empty){let i=replaceStep(this.doc,e,t,n);i&&this.step(i);return this}replaceWith(e,n,i){return this.replace(e,n,new r(t.from(i),0,0))}delete(e,t){return this.replace(e,t,r.empty)}insert(e,t){return this.replaceWith(e,e,t)}replaceRange(e,t,r){replaceRange(this,e,t,r);return this}replaceRangeWith(e,t,r){replaceRangeWith(this,e,t,r);return this}deleteRange(e,t){deleteRange(this,e,t);return this}lift(e,t){lift(this,e,t);return this}join(e,t=1){join(this,e,t);return this}wrap(e,t){wrap(this,e,t);return this}setBlockType(e,t=e,r,n=null){setBlockType(this,e,t,r,n);return this}setNodeMarkup(e,t,r=null,n){setNodeMarkup(this,e,t,r,n);return this}setNodeAttribute(e,t,r){this.step(new AttrStep(e,t,r));return this}setDocAttribute(e,t){this.step(new DocAttrStep(e,t));return this}addNodeMark(e,t){this.step(new AddNodeMarkStep(e,t));return this}removeNodeMark(e,t){if(!(t instanceof i)){let r=this.doc.nodeAt(e);if(!r)throw new RangeError("No node at position "+e);t=t.isInSet(r.marks);if(!t)return this}this.step(new RemoveNodeMarkStep(e,t));return this}split(e,t=1,r){split(this,e,t,r);return this}addMark(e,t,r){addMark(this,e,t,r);return this}removeMark(e,t,r){removeMark(this,e,t,r);return this}clearIncompatible(e,t,r){clearIncompatible(this,e,t,r);return this}}export{AddMarkStep,AddNodeMarkStep,AttrStep,DocAttrStep,MapResult,Mapping,RemoveMarkStep,RemoveNodeMarkStep,ReplaceAroundStep,ReplaceStep,Step,StepMap,StepResult,Transform,d as TransformError,canJoin,canSplit,dropPoint,findWrapping,insertPoint,joinPoint,liftTarget,replaceStep};


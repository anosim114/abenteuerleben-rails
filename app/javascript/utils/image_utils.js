window.squashImageFile = (element) => {
    
    if (imageSmallEnough(element)) {
        return
    }
    
    resizeImage(element)
}

function imageSmallEnough(element) {
    const MAX_SIZE = 3

    if (element.files.length === 0) {
        return true
    }

    const size_in_mb = element.files[0].size / 1024 / 1024

    if (size_in_mb < MAX_SIZE) {
        return true
    }

    return false
}

function resizeImage(element) {
    const file = element.files[0]
    const oldName = file.name
    const reader = new FileReader()

    // 2
    reader.onload = e => {
        const img = document.createElement('img')

        // 4
        img.onload = () => {
            const canvas = document.createElement('canvas')
            const ctx = canvas.getContext('2d')

            let { width, height } = getMaxWidthHeight(img.width, img.height);

            canvas.width = width
            canvas.height = height
            
            ctx.drawImage(img, 0, 0, width, height)

            putCanvasToInput(canvas, element, oldName)
        }
    
        // 3
        img.src = e.target.result
    }

    // 1
    reader.readAsDataURL(file)
}

function getMaxWidthHeight(oldWidth, oldHeight) {
    const MAX_WIDTH = 2000
    const MAX_HEIGHT = 2000

    let width = oldWidth
    let height = oldHeight

    if (width > MAX_WIDTH) {
        const ratio = width / MAX_WIDTH
        width = width / ratio
        height = height / ratio
    }

    if (height > MAX_HEIGHT) {
        const ratio = height / MAX_HEIGHT
        width = width / ratio
        height = height / ratio
    }

    return { width, height }
}

function putCanvasToInput(canvas, element, fileName) {
    canvas.toBlob(blob => {
        const file = new File([blob], fileName, { type: 'image/jpeg' })
        const dt = new DataTransfer()

        dt.items.add(file)

        element.files = dt.files

    }, 'image/jpeg')
}

import Swal from 'sweetalert2'
export const clearFormerror = (me) => {
    me.closest('.formelement').querySelector('.formelement__error')?.remove()
}

export const submitIfOk = async (button) => {
    const isOkResult = await Swal.fire({
        text: 'Wirklich löschen?',
        icon: 'warning',
        showCancelButton: true,
    })

    if (isOkResult.isConfirmed) {
        button.closest('form').requestSubmit()
    }
}

import Swal from 'sweetalert2'

export const resendParentVerificationEMail = async (id) => {
    console.debug('resending verification email')

    const result = await fetch(`/parents/${id}/resend_verification_mail`)
    const text = await result.text()

    console.debug(result.status)
    if (result.status !== 200) {
        return Swal.fire({
            icon: 'error',
            text: text
        })
    }

    Swal.fire({
        icon: 'success',
        text: text
    })
}

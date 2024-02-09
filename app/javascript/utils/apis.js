import swal from 'sweetalert'

export const resendParentVerificationEMail = async (id) => {
    console.debug('resending verification email')

    const result = await fetch(`/parents/${id}/resend_verification_mail`)
    const text = await result.text()

    console.debug(result.status)
    if (result.status !== 200) {
        return swal({
            icon: 'error',
            text: text
        })
    }

    swal({
        icon: 'success',
        text: text
    })
}

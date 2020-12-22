From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: client UUID: Skip REE kernel login method as well
Date: Tue, 22 Dec 2020 10:50:39 +0200
Message-ID: <d8f255bf-c3ec-a54a-526f-bf9172a2986c@vaisala.com>
In-Reply-To: <
 <CAHUa44FPG3kx3DBr-cZKttwH0_L-1=bTGoz6y7Mjj6WS3VKBdw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6308718310858018659=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6308718310858018659==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 2020-10-08 08:53, Jens Wiklander wrote:
> Hi Sumit,
>=20
> On Wed, Oct 7, 2020 at 11:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> Hi Jens,
>>
>> On Thu, 17 Sep 2020 at 19:10, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> Since the addition of session's client UUID generation via commit [1],
>>> login via REE kernel method was disallowed. So fix that via passing
>>> nill UUID in case of TEE_IOCTL_LOGIN_REE_KERNEL method as well.
>>>
>>> Fixes: e33bcbab16d1 ("tee: add support for session's client UUID generati=
on") [1]
>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>> ---
>>>   drivers/tee/tee_core.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>
>> Would you like to pick up this fix?
>=20
> Thanks for the reminder.
> This looks good to me. I'll pick up this unless someone objects.
> Vesa, does this look good to you too?
>=20
> Cheers,
> Jens

Sorry I have been away for a while from the mailing list.

It seems that this is merged -- only thing that came to my mind with=20
this is that:

If we have some kernel protected keys or so -- should we have separate=20
client UUID for kernel operations.

Like when TEE_IOCTL_LOGIN_REE_KERNEL is given then client UUID would be=20
generated for "kernel".

This way we can make sure that kernel owned keys stays for kernel. Nil=20
UUID is kinda reserved for public login.

Thanks,
Vesa J=C3=A4=C3=A4skel=C3=A4inen

>=20
>>
>> -Sumit
>>
>>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>>> index 64637e0..2f6199e 100644
>>> --- a/drivers/tee/tee_core.c
>>> +++ b/drivers/tee/tee_core.c
>>> @@ -200,7 +200,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 co=
nnection_method,
>>>          int name_len;
>>>          int rc;
>>>
>>> -       if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC) {
>>> +       if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC ||
>>> +           connection_method =3D=3D TEE_IOCTL_LOGIN_REE_KERNEL) {
>>>                  /* Nil UUID to be passed to TEE environment */
>>>                  uuid_copy(uuid, &uuid_null);
>>>                  return 0;
>>> --
>>> 2.7.4
>>>


--===============6308718310858018659==--


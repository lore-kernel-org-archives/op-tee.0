From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: client UUID: Skip REE kernel login method as well
Date: Tue, 22 Dec 2020 14:16:56 +0200
Message-ID: <3fa238db-a75d-f7c8-7836-45f680670877@vaisala.com>
In-Reply-To: <20201222122443.5725c0b3@akathisia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6167209978726421820=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6167209978726421820==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2020-12-22 11:24, Elvira Khabirova wrote:
> On Tue, 22 Dec 2020 08:50:56 +0000
> Vesa J=C3=A4=C3=A4skel=C3=A4inen via OP-TEE <op-tee@lists.trustedfirmware=
.org> wrote:
>=20
>> Hi,
>>
>> On 2020-10-08 08:53, Jens Wiklander wrote:
>>> Hi Sumit,
>>>
>>> On Wed, Oct 7, 2020 at 11:27 AM Sumit Garg <sumit.garg@linaro.org> wrot=
e:
>>>>
>>>> Hi Jens,
>>>>
>>>> On Thu, 17 Sep 2020 at 19:10, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>>
>>>>> Since the addition of session's client UUID generation via commit [1],
>>>>> login via REE kernel method was disallowed. So fix that via passing
>>>>> nill UUID in case of TEE_IOCTL_LOGIN_REE_KERNEL method as well.
>>>>>
>>>>> Fixes: e33bcbab16d1 ("tee: add support for session's client UUID genera=
tion") [1]
>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>>> ---
>>>>>    drivers/tee/tee_core.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>
>>>> Would you like to pick up this fix?
>>>
>>> Thanks for the reminder.
>>> This looks good to me. I'll pick up this unless someone objects.
>>> Vesa, does this look good to you too?
>>>
>>> Cheers,
>>> Jens
>>
>> Sorry I have been away for a while from the mailing list.
>>
>> It seems that this is merged -- only thing that came to my mind with
>> this is that:
>>
>> If we have some kernel protected keys or so -- should we have separate
>> client UUID for kernel operations.
>>
>> Like when TEE_IOCTL_LOGIN_REE_KERNEL is given then client UUID would be
>> generated for "kernel".
>>
>> This way we can make sure that kernel owned keys stays for kernel. Nil
>> UUID is kinda reserved for public login.
>=20
> Isn't this unnecessary? According to the TEE Internal Core API Specificatio=
n,
> TEE_Identity, a data type that "defines the full identity of a Client", con=
sists
> of a UUID *and* one of the TEE_LOGIN_XXX constants. Therefore, TEE_LOGIN_PU=
BLIC
> with a nil UUID is a different client than TEE_LOGIN_REE_KERNEL with a nil =
UUID.

Not sure yet.

"Generic calls" to TEE from kernel without any context could go with=20
TEE_LOGIN_REE_KERNEL:<nil UUID>.

We can extend that while we go forward when the TEE Identity is used in=20
the TA to control which party is allowed to use the service OR if the=20
service is aware if identity and just stores ownership for the=20
data/secret and then checks that it is matching when being accessed again.

I am wondering if we have cases within kernel were we need to be aware=20
on the path were the request is coming from.

Sumit Garg has been working on TEE based Trusted Keys and at least there=20
could be own "context".

Then we have Crypto API where one can do some operations:
https://www.kernel.org/doc/html/v5.10/crypto/api-akcipher.html#c.crypto_akcip=
her_set_priv_key

But probably the API itself does not bring context but where it is used=20
from.

Only way to distinguish those from each other would be=20
TEE_LOGIN_REE_KERNEL:<UUID>.

I don't think there is immediate need to change what is currently there=20
-- more on the use case when the need arises.

Thanks,
Vesa J=C3=A4=C3=A4skel=C3=A4inen

--===============6167209978726421820==--


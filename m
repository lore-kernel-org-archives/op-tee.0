From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant based device enumeration
Date: Wed, 11 Oct 2023 14:45:35 +0000
Message-ID: <a9515560-32bc-4f3b-a36c-87f7242081a9@siemens.com>
In-Reply-To: <
 <CAFA6WYP7hgRWS_gp2AFEWDs27aOeUndB6+1dh95TtW2s1N+5Ag@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7865670684783775582=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7865670684783775582==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29.08.23 13:03, Sumit Garg wrote:
> Hi Jan,
>=20
> On Fri, 28 Jul 2023 at 19:18, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> Currently supplicant dependent optee device enumeration only registers
>> devices whenever tee-supplicant is invoked for the first time. But it
>> forgets to remove devices when tee-supplicant daemon stops running and
>> closes its context gracefully. This leads to following error for fTPM
>> driver during reboot/shutdown:
>>
>> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error=
: 0xffff3024
>>
>> Fix this by separating supplicant dependent devices so that the
>> user-space service can detach supplicant devices before closing the
>> supplicant. While at it use the global system workqueue for OP-TEE bus
>> scanning work rather than our own custom one.
>>
>> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Link: https://github.com/OP-TEE/optee_os/issues/6094
>=20
> I see you have marked this issue as resolved. It would be good to have
> your tested-by tag if it works for you.
>=20

Sorry for this very late reply. We finally validated that this works
fine for us, though only over 6.1, our current test target. I hope we
can enable tip of tree soon as well. But I think I can still add my

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

--=20
Siemens AG, Technology
Linux Expert Center


--===============7865670684783775582==--


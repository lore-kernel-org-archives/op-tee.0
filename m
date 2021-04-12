From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
Date: Mon, 12 Apr 2021 15:49:51 +0530
Message-ID: <1318f015-40cb-2bdd-17fb-2a3843ed45bc@amd.com>
In-Reply-To: <
 <CAHUa44Gga=k3indU8FC3X5xE=6RnKEDNeZBDWeJzm47-Spm0QA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6735762283876235735=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6735762283876235735==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 12/04/21 1:06 pm, Jens Wiklander wrote:
> On Mon, Apr 5, 2021 at 11:43 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wr=
ote:
>>
>> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>>
>> If it is a single instance TA, the TA should not get unloaded from AMD
>> Secure Processor, while it is still in use in another TEE context.
>>
>> Therefore reference count TA and unload it when the count becomes zero.
>>
>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>> v2:
>>  * Unload TA if get_ta_refcount() fails
>>
>>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
>>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
>>  drivers/tee/amdtee/core.c           | 15 +++--
>>  3 files changed, 106 insertions(+), 16 deletions(-)
>=20
> Looks good to me. Please address Dan's comment.
>=20

Hi Jens,

I have replied to Dan's comment.

If you are okay with the current patch, request you to pull this.

Thanks,
Rijo

> Cheers,
> Jens
>=20

--===============6735762283876235735==--


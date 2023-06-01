From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date: Thu, 01 Jun 2023 08:31:33 +0300
Message-ID: 
 <CAC_iWjKAdimEH0SsC_z9QuFS4sGLp2BVzx03s+RKvcLXY25kuQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CSN7PR11MB6850DA4A185E3429B62531CD84499=40SN7PR11MB?=
 =?utf-8?q?6850=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3879254543620116972=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3879254543620116972==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Bing

On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
>
> As an alternative, Is it possible to change ftpm design not to depend on RP=
MB access at the earlier/boot stage? Because to my understanding, typically P=
CRs don't require persistent/NV storage (for example, before RPMB or tee-supp=
licant is ready, use TEE memory instead as temporary storage)

I am not entirely sure this will solve our problem here.  You are
right that we shouldn't depend on the supplicant to extend PCRs. But
what happens if an object is sealed against certain PCR values?  We
are back to the same problem

Thanks
/Ilias
>
> Bing
>
> IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4bc7-=
bb2f-442c1b17af26)
> System Software Engineering
> Software and Advanced Technology Group
> Zizhu Science Park, Shanghai, China
>
> -----Original Message-----
> From: Shyam Saini <shyamsaini@linux.microsoft.com>
> Sent: Thursday, June 1, 2023 3:10 AM
> To: alex.bennee(a)linaro.org
> Cc: code(a)tyhicks.com; Matti.Moell(a)opensynergy.com; arnd(a)linaro.org; Z=
hu, Bing <bing.zhu@intel.com>; hmo(a)opensynergy.com; ilias.apalodimas(a)li=
naro.org; joakim.bech(a)linaro.org; linux-kernel(a)vger.kernel.org; linux-mmc=
(a)vger.kernel.org; linux-scsi(a)vger.kernel.org; maxim.uvarov(a)linaro.org; =
ruchika.gupta(a)linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.h=
ansson(a)linaro.org; Huang, Yang <yang.huang@intel.com>; sumit.garg(a)linar=
o.org; jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org
> Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
>
> Hi Alex,
>
> [ Resending, Sorry for the noise ]
>
> Are you still working on it or planning to resubmit it ?
>
> [1] The current optee tee kernel driver implementation doesn't work when IM=
A is used with optee implemented ftpm.
>
> The ftpm has dependency on tee-supplicant which comes once the user space i=
s up and running and IMA attestation happens at boot time and it requires to =
extend ftpm PCRs.
>
> But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee can=
 only access RPMB via tee-supplicant(user space). So, there should be a fast =
path to allow optee os to access the RPMB parititon without waiting for user-=
space tee supplicant.
>
> To achieve this fast path linux optee driver and mmc driver needs some work=
 and finally it will need RPMB driver which you posted.
>
> Please let me know what's your plan on this.
>
> [1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html
>
> Best Regards,
> Shyam

--===============3879254543620116972==--


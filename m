From: Robert Deliën <robert@delien.nl>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure memory allocation
Date: Wed, 02 Dec 2020 20:28:32 +0000
Message-ID: <AM0PR08MB345984ACBBE6D43E6C4990AEC5F30@AM0PR08MB3459.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAHUa44HfYrQR1ErvjrsoGAp7bZL_vAsTN4Qh5_r9r+CoHgoWig@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1755009565681503641=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1755009565681503641==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Thank you very much for your prompt answer.

> It looks like something went wrong in the first solution.

Ok. Since I don't fully understand the failure mode, I'm going to abandon tha=
t solution.

> The failure
> in the last solution is because OP-TEE thinks that you've accidentally
> tried to configure non-secure memory as secure memory.

Ok, I figured that much, so that's clearly not the way to go.

> I think the easiest is to allocate memory from the pool used for TAs with:
> mm =3D tee_mm_alloc(&tee_mm_sec_ddr, size);
> Until this mm is freed no one else will use the memory it represents.

That's a great idea! And thanks to this solution, I don't have to discard hal=
f a day of work refactoring the code to use calloc. because It was fairly eas=
y to convert from calloc to tee_mm_alloc.

> Returned memory is page aligned (based on CORE_MMU_USER_CODE_SHIFT).

I wasn't really sure exactly what it is that tee_mm_alloc() returns, but two =
consecutive calls for 0x96000 bytes of data produced returned values (1st =3D=
 0x8e076e60, 2nd =3D 0x8e076e48) of only 0x18 bytes apart. So perhaps they're=
 TLB entries?
But I went through the code for examples and this is what I came up with:

	/* Allocate memory for all frame buffers */
	for (ndx =3D 0; ndx < ARRAY_SIZE(fb); ndx++) {
		tee_mm_entry_t  *mm;

		if (!(mm =3D tee_mm_alloc(&tee_mm_sec_ddr, MXSFB_SIZE))) {
			EMSG("Error allocating fb[%d]\n", ndx);
			return;
		}
		fb[ndx].va =3D phys_to_virt(tee_mm_get_smem(mm), MEM_AREA_TA_RAM);
		fb[ndx].pa =3D (void *)virt_to_phys(fb[ndx].va);
		DMSG("fb[%d] @%p (pa %p)\n", ndx, fb[ndx].va, fb[ndx].pa);
		memset(fb[ndx].va, 0x00, MXSFB_SIZE);
	}
Does that look al right to you?
Could you suggest a more elegant way to convert the contents of mm to fb[ndx]=
.va and fb[ndx].pa?
Is the memset() still necessary? I didn't see that in any of the examples I'v=
e found, and it's an expensive function.
Is the memory allocated with tee_mm_alloc() garranteed to be a single block o=
f consecutive pages?

> This depends on paging being disabled, which it seems it is for the
> IMX platforms.
> If paging would have been enabled this memory might have been less
> secure than what you require, depending on how the platform is
> configured.

Paging is disabled, so we're good here. Thank you for making me check.

Again, thank you very much!

--===============1755009565681503641==--


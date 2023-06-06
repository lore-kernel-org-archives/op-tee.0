From: Ard Biesheuvel <ardb@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Tue, 06 Jun 2023 08:57:52 +0200
Message-ID: 
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8148443322375831109=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8148443322375831109==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jun 2023 at 08:52, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jan,
>
> On Tue, 6 Jun 2023 at 12:09, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 26.05.23 03:07, Masahisa Kojima wrote:
> > > When the flash is not owned by the non-secure world, accessing the EFI
> > > variables is straightforward and done via EFI Runtime Variable Services.
> > > In this case, critical variables for system integrity and security
> > > are normally stored in the dedicated secure storage and only accessible
> > > from the secure world.
> > >
> > > On the other hand, the small embedded devices don't have the special
> > > dedicated secure storage. The eMMC device with an RPMB partition is
> > > becoming more common, we can use an RPMB partition to store the
> > > EFI Variables.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > for EFI Variables, it is implemented by interacting with
> > > TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo T=
A),
> > > eMMC driver and tee-supplicant. The last piece is the tee-based
> > > variable access driver to interact with TEE and StandaloneMM.
> > >
> > > So let's add the kernel functions needed.
> > >
> > > This feature is implemented as a kernel module.
> > > StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> > > so that this tee_stmm_efi module is probed after tee-supplicant starts,
> > > since "SetVariable" EFI Runtime Variable Service requires to
> > > interact with tee-supplicant.
> > >
> > > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> > > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > ---
> > >  drivers/firmware/efi/Kconfig                 |  15 +
> > >  drivers/firmware/efi/Makefile                |   1 +
> > >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
> > >  4 files changed, 890 insertions(+)
> > >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> > >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> > >
...
> >
> > I think we have a probe ordering issue with this driver:
> > efivarfs_fill_super() may be called before the TEE bus was probed, thus
> > with the default efivar ops still registered. And that means
> > efivar_supports_writes() will return false, and the fs declares itself
> > as readonly. I've seen systemd mounting it r/o initialling, and you need
> > to remount the fs to enable writability.
> >
> > Is there anything that could be done to re-order things reliably, probe
> > the tee bus earlier etc.?
>
> This driver has a dependency on user-space daemon: tee-supplicant to
> be running for RPMB access. So once you start that daemon the
> corresponding device will be enumerated on the TEE bus and this driver
> probe will be invoked. So I would suggest you to load this daemon very
> early in the boot process or better to make it a part of initramfs.
>

That is not the point, really.

If this dependency exists, the code should be aware of that, and made
to work correctly in spite of it. Requiring a module to be part of
initramfs is not a reasonable fix.

IIUC, this also means that the efivar ops are updated while there is
already a client. This seems less than ideal as well

--===============8148443322375831109==--


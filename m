From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
Date: Sat, 09 Nov 2024 00:31:14 +0000
Message-ID: 
 <CAC_iWjJLSSTO0Ca7rgOWAHfWzbkBkKHkQedRUbcwsoU0dtrsGA@mail.gmail.com>
In-Reply-To: <
 <CALE0LRtUz8hd4pdR9sX2Sb6tOn=K4wkRnGG9B7f72qU8JFQSYQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6962705672667503277=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6962705672667503277==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb@redhat.com> w=
rote:
>
> Hi Ilias,
>
> Thanks for your quick answer.
>
> On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Enric,
> >
> > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb@redhat.co=
m> wrote:
> > >
> > > Hi all,
> > >
> > > I'm looking for any advice/clue to help me to progress on enabling
> > > TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.
> > >
> > > I basically followed the steps described in u-boot documentation [1],
> > > I enabled some debugging messages but I think I'm at the point that
> > > the problem might be in the StandaloneMM application, and I'm not sure
> > > how to debug it.
> > >
> > > What I see is that when I run the tee-supplicant daemon, it looks like
> > > the tee_client_open_session() call loops forever and the tee_stmm_efi
> > > driver never ends to probe.
> > >
> > > With debug enabled I got the following messages.
> >
> > I assume reading and storing variables already works in U-Boot right?
> >
>
> Reading and storing variables to the RPMB partition in U-Boot works,
> that's using the mmc rpmb command from u-boot,

Are you talking about env variables? Perhaps you store them in the mmc
and not the RPMB partition?
There's some information here [0]

> But setting
> CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behaviour
> (although I'm not able to debug at u-boot level) What I see is that
> u-boot gets stuck
> when bootefi bootmgr is invoqued. I can also reproduce the issue with
> bootefi hello.
>
> =3D> run bootcmd
>   Scanning for bootflows in all bootdevs
>   Seq  Method       State   Uclass    Part  Name                      Filen=
ame
>   ---  -----------  ------  --------  ----  ------------------------
> ----------------
>   Scanning global bootmeth 'efi_mgr':
> ( gets stuck here)
>
> or
>
> =3D> bootefi hello
> (gets stuck)
>
> To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and bypass
> the error and go to Linux. My understanding is that
> CONFIG_EFI_MM_COMM_TEE is only required to read/write efi variables at
> u-boot level but OPTEE is running the StandaloneMM service. Am I
> right?

U-Boot has two ways of storing EFI variables [0] . You can either
store them in a file or the RPMB partition. The correct thing to do,
since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_TEE. I am
not sure why the hand happens, but one thing we can improve is figure
out why it hangs and print a useful message.
There are a number of reasons that might lead to a failure. Is the
RPMB key programmed on your board? Have a look at this [1] in case it
helps

>
> > >
> > > # tee-supplicant
> > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted service
> > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request

If I had to guess, OP-TEE doesn't store the variables in the RPMB, can
you compile it with a bit more debugging enabled?

> > >
> > > And tracing the function calls gives me that:
> > >
> > >       tee_stmm_efi_probe() {
> > >              tee_client_open_context() {
> > >                optee_get_version() {
> > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                } (ret=3D0xd)
> > >                tee_ctx_match(); (ret=3D0x1)
> > >                optee_smc_open() {
> > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                  optee_open() {
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                  } (ret=3D0x0)
> > >                } (ret=3D0x0)
> > >              } (ret=3D0xffff000004e71c80)
> > >              tee_client_open_session() {
> > >                optee_open_session() {
> > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                  optee_get_msg_arg() {
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > >                  } (ret=3D0xffff000002909000)
> > >                  tee_session_calc_client_uuid(); (ret=3D0x0)
> > >                  optee_to_msg_param(); (ret=3D0x0)
> > >                  optee_smc_do_call_with_arg() {
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    tee_shm_get_va(); (ret=3D0xffff000002909000)
> > >                    tee_shm_get_va(); (ret=3D0xffff000002909060)
> > >                    optee_cq_wait_init(); (ret=3D0xffff000002e55910)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > >      ... continues sending this forever ...
> > >      ... Hit ^C to stop recording ...
> > >                    tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > >                    optee_smccc_smc() {
> > >
> > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op-t=
ee-for-efi-variables
> > >
> > > Thanks in advance,
> >
> > The most common problem with this is miscompiling the tee_supplicant
> > application.
> > Since we don't know if the system has an RPMB, we emulate it in the
> > tee_supplicant. How did you get the supplicant and can you check if it
> > was compiled with RPMB_EMU=3D0 or 1?
> >
>
> I'm using the tee-supplicant provided by the fedora package which is
> built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
>

Yes, this is correct. We fixed the Fedora package to compile the
supplicant correctly a while back.

[0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
[1] https://apalos.github.io/Protected%20UEFI%20variables%20with%20U-Boot.htm=
l#Protected%20UEFI%20variables%20with%20U-Boot


Regards
/Ilias
> Thanks,
>    Enric
>
> > Thanks
> > /Ilias
> >
> > >    Enric
> > >
> >
>

--===============6962705672667503277==--


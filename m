From: Enric Balletbo i Serra <eballetb@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: optee-based efi runtime variable service on TI j784s4 platforms
Date: Fri, 08 Nov 2024 13:26:12 +0100
Message-ID: 
 <CALE0LRvJ-n77oU=O9__NdSLw2v33zMK+WYkn2LcwWMwHCbohQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1429786119741971653=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1429786119741971653==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm looking for any advice/clue to help me to progress on enabling
TEE-base EFI Runtime Variable Service on TI a j784s4 platforms.

I basically followed the steps described in u-boot documentation [1],
I enabled some debugging messages but I think I'm at the point that
the problem might be in the StandaloneMM application, and I'm not sure
how to debug it.

What I see is that when I run the tee-supplicant daemon, it looks like
the tee_client_open_session() call loops forever and the tee_stmm_efi
driver never ends to probe.

With debug enabled I got the following messages.

# tee-supplicant
D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted service
7011a688-ddde-4053-a5a9-7b3c4ddf13b8
D/TC:? 0 load_stmm:297 stmm load address 0x40004000
D/TC:? 0 spm_handle_scall:859 Received FFA version
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request
D/TC:? 0 spm_handle_scall:867 Received FFA direct request

And tracing the function calls gives me that:

      tee_stmm_efi_probe() {
             tee_client_open_context() {
               optee_get_version() {
                 tee_get_drvdata(); (ret=3D0xffff000002e55800)
               } (ret=3D0xd)
               tee_ctx_match(); (ret=3D0x1)
               optee_smc_open() {
                 tee_get_drvdata(); (ret=3D0xffff000002e55800)
                 optee_open() {
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                 } (ret=3D0x0)
               } (ret=3D0x0)
             } (ret=3D0xffff000004e71c80)
             tee_client_open_session() {
               optee_open_session() {
                 tee_get_drvdata(); (ret=3D0xffff000002e55800)
                 optee_get_msg_arg() {
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                   tee_shm_get_va(); (ret=3D0xffff000002909000)
                 } (ret=3D0xffff000002909000)
                 tee_session_calc_client_uuid(); (ret=3D0x0)
                 optee_to_msg_param(); (ret=3D0x0)
                 optee_smc_do_call_with_arg() {
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                   tee_shm_get_va(); (ret=3D0xffff000002909000)
                   tee_shm_get_va(); (ret=3D0xffff000002909060)
                   optee_cq_wait_init(); (ret=3D0xffff000002e55910)
                   optee_smccc_smc(); (ret=3D0xffff0004)
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                   optee_smccc_smc(); (ret=3D0xffff0004)
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                   optee_smccc_smc(); (ret=3D0xffff0004)
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                   optee_smccc_smc(); (ret=3D0xffff0004)
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                   optee_smccc_smc(); (ret=3D0xffff0004)
     ... continues sending this forever ...
     ... Hit ^C to stop recording ...
                   tee_get_drvdata(); (ret=3D0xffff000002e55800)
                   optee_smccc_smc() {

[1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#using-op-tee-for=
-efi-variables

Thanks in advance,
   Enric


--===============1429786119741971653==--


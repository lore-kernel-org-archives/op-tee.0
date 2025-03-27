From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 04/10] optee: sync secure world ABI headers
Date: Thu, 27 Mar 2025 08:41:58 +0100
Message-ID: 
 <CAHUa44FO4NR90UsQQMNBC7n=4wE-bC+71OR5r7-gzFZBf+-76A@mail.gmail.com>
In-Reply-To: <Z-JLLHcrt1pwXe7J@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1171587130278204858=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1171587130278204858==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Tue, Mar 25, 2025 at 7:20=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> Hi Jens,
>
> It has taken a bit of time for me to review this patch-set as I am
> settling in my new role.
>
> On Wed, Mar 05, 2025 at 02:04:10PM +0100, Jens Wiklander wrote:
> > Update the header files describing the secure world ABI, both with and
> > without FF-A. The ABI is extended to deal with restricted memory, but as
> > usual backward compatible.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/optee_ffa.h | 27 ++++++++++---
> >  drivers/tee/optee/optee_msg.h | 65 ++++++++++++++++++++++++++++++--
> >  drivers/tee/optee/optee_smc.h | 71 ++++++++++++++++++++++++++++++++++-
> >  3 files changed, 154 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
> > index 257735ae5b56..7bd037200343 100644
> > --- a/drivers/tee/optee/optee_ffa.h
> > +++ b/drivers/tee/optee/optee_ffa.h
> > @@ -81,7 +81,7 @@
> >   *                   as the second MSG arg struct for
> >   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
> >   *        Bit[31:8]: Reserved (MBZ)
> > - * w5:         Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_*=
 below,
> > + * w5:         Bitfield of OP-TEE capabilities OPTEE_FFA_SEC_CAP_*
> >   * w6:         The maximum secure world notification number
> >   * w7:         Not used (MBZ)
> >   */
> > @@ -94,6 +94,8 @@
> >  #define OPTEE_FFA_SEC_CAP_ASYNC_NOTIF        BIT(1)
> >  /* OP-TEE supports probing for RPMB device if needed */
> >  #define OPTEE_FFA_SEC_CAP_RPMB_PROBE BIT(2)
> > +/* OP-TEE supports Restricted Memory for secure data path */
> > +#define OPTEE_FFA_SEC_CAP_RSTMEM     BIT(3)
> >
> >  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
> >
> > @@ -108,7 +110,7 @@
> >   *
> >   * Return register usage:
> >   * w3:    Error code, 0 on success
> > - * w4-w7: Note used (MBZ)
> > + * w4-w7: Not used (MBZ)
> >   */
> >  #define OPTEE_FFA_UNREGISTER_SHM     OPTEE_FFA_BLOCKING_CALL(3)
> >
> > @@ -119,16 +121,31 @@
> >   * Call register usage:
> >   * w3:    Service ID, OPTEE_FFA_ENABLE_ASYNC_NOTIF
> >   * w4:         Notification value to request bottom half processing, sho=
uld be
> > - *     less than OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE.
> > + *     less than OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE
> >   * w5-w7: Not used (MBZ)
> >   *
> >   * Return register usage:
> >   * w3:    Error code, 0 on success
> > - * w4-w7: Note used (MBZ)
> > + * w4-w7: Not used (MBZ)
> >   */
> >  #define OPTEE_FFA_ENABLE_ASYNC_NOTIF OPTEE_FFA_BLOCKING_CALL(5)
> >
> > -#define OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE 64
> > +#define OPTEE_FFA_MAX_ASYNC_NOTIF_VALUE      64
> > +
> > +/*
> > + * Release Restricted memory
> > + *
> > + * Call register usage:
> > + * w3:    Service ID, OPTEE_FFA_RECLAIM_RSTMEM
> > + * w4:    Shared memory handle, lower bits
> > + * w5:    Shared memory handle, higher bits
> > + * w6-w7: Not used (MBZ)
> > + *
> > + * Return register usage:
> > + * w3:    Error code, 0 on success
> > + * w4-w7: Note used (MBZ)
> > + */
> > +#define OPTEE_FFA_RELEASE_RSTMEM     OPTEE_FFA_BLOCKING_CALL(8)
> >
> >  /*
> >   * Call with struct optee_msg_arg as argument in the supplied shared mem=
ory
> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > index e8840a82b983..1b558526e7d9 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -133,13 +133,13 @@ struct optee_msg_param_rmem {
> >  };
> >
> >  /**
> > - * struct optee_msg_param_fmem - ffa memory reference parameter
> > + * struct optee_msg_param_fmem - FF-A memory reference parameter
> >   * @offs_lower:         Lower bits of offset into shared memory reference
> >   * @offs_upper:         Upper bits of offset into shared memory reference
> >   * @internal_offs: Internal offset into the first page of shared memory
> >   *              reference
> >   * @size:       Size of the buffer
> > - * @global_id:          Global identifier of Shared memory
> > + * @global_id:          Global identifier of the shared memory
> >   */
> >  struct optee_msg_param_fmem {
> >       u32 offs_low;
> > @@ -165,7 +165,7 @@ struct optee_msg_param_value {
> >   * @attr:    attributes
> >   * @tmem:    parameter by temporary memory reference
> >   * @rmem:    parameter by registered memory reference
> > - * @fmem:    parameter by ffa registered memory reference
> > + * @fmem:    parameter by FF-A registered memory reference
> >   * @value:   parameter by opaque value
> >   * @octets:  parameter by octet string
> >   *
> > @@ -296,6 +296,18 @@ struct optee_msg_arg {
> >   */
> >  #define OPTEE_MSG_FUNCID_GET_OS_REVISION     0x0001
> >
> > +/*
> > + * Values used in OPTEE_MSG_CMD_LEND_RSTMEM below
> > + * OPTEE_MSG_RSTMEM_RESERVED         Reserved
> > + * OPTEE_MSG_RSTMEM_SECURE_VIDEO_PLAY        Secure Video Playback
> > + * OPTEE_MSG_RSTMEM_TRUSTED_UI               Trused UI
> > + * OPTEE_MSG_RSTMEM_SECURE_VIDEO_RECORD      Secure Video Recording
> > + */
> > +#define OPTEE_MSG_RSTMEM_RESERVED            0
> > +#define OPTEE_MSG_RSTMEM_SECURE_VIDEO_PLAY   1
> > +#define OPTEE_MSG_RSTMEM_TRUSTED_UI          2
> > +#define OPTEE_MSG_RSTMEM_SECURE_VIDEO_RECORD 3
> > +
> >  /*
> >   * Do a secure call with struct optee_msg_arg as argument
> >   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::=
cmd
> > @@ -337,6 +349,49 @@ struct optee_msg_arg {
> >   * OPTEE_MSG_CMD_STOP_ASYNC_NOTIF informs secure world that from now is
> >   * normal world unable to process asynchronous notifications. Typically
> >   * used when the driver is shut down.
> > + *
> > + * OPTEE_MSG_CMD_LEND_RSTMEM lends restricted memory. The passed normal
> > + * physical memory is restricted from normal world access. The memory
> > + * should be unmapped prior to this call since it becomes inaccessible
> > + * during the request.
> > + * Parameters are passed as:
> > + * [in] param[0].attr                        OPTEE_MSG_ATTR_TYPE_VALUE_I=
NPUT
> > + * [in] param[0].u.value.a           OPTEE_MSG_RSTMEM_* defined above
> > + * [in] param[1].attr                        OPTEE_MSG_ATTR_TYPE_TMEM_IN=
PUT
> > + * [in] param[1].u.tmem.buf_ptr              physical address
> > + * [in] param[1].u.tmem.size         size
> > + * [in] param[1].u.tmem.shm_ref              holds restricted memory ref=
erence
> > + *
> > + * OPTEE_MSG_CMD_RECLAIM_RSTMEM reclaims a previously lent restricted
> > + * memory reference. The physical memory is accessible by the normal wor=
ld
> > + * after this function has return and can be mapped again. The informati=
on
> > + * is passed as:
> > + * [in] param[0].attr                        OPTEE_MSG_ATTR_TYPE_VALUE_I=
NPUT
> > + * [in] param[0].u.value.a           holds restricted memory cookie
> > + *
> > + * OPTEE_MSG_CMD_GET_RSTMEM_CONFIG get configuration for a specific
> > + * restricted memory use case. Parameters are passed as:
> > + * [in] param[0].attr                        OPTEE_MSG_ATTR_TYPE_VALUE_I=
NOUT
> > + * [in] param[0].value.a             OPTEE_MSG_RSTMEM_*
> > + * [in] param[1].attr                        OPTEE_MSG_ATTR_TYPE_{R,F}ME=
M_OUTPUT
> > + * [in] param[1].u.{r,f}mem          Buffer or NULL
> > + * [in] param[1].u.{r,f}mem.size     Provided size of buffer or 0 for qu=
ery
> > + * output for the restricted use case:
> > + * [out] param[0].value.a            Minimal size of SDP memory
> > + * [out] param[0].value.b            Required alignment of size and star=
t of
> > + *                                   restricted memory
> > + * [out] param[1].{r,f}mem.size              Size of output data
> > + * [out] param[1].{r,f}mem           If non-NULL, contains an array of
> > + *                                   uint16_t holding endpoints that
> > + *                                   must be included when lending
> > + *                                   memory for this use case
> > + *
> > + * OPTEE_MSG_CMD_ASSIGN_RSTMEM assigns use-case to restricted memory
> > + * previously lent using the FFA_LEND framework ABI. Parameters are pass=
ed
> > + * as:
> > + * [in] param[0].attr                        OPTEE_MSG_ATTR_TYPE_VALUE_I=
NPUT
> > + * [in] param[0].u.value.a           holds restricted memory cookie
> > + * [in] param[0].u.value.b           OPTEE_MSG_RSTMEM_* defined above
> >   */
> >  #define OPTEE_MSG_CMD_OPEN_SESSION   0
> >  #define OPTEE_MSG_CMD_INVOKE_COMMAND 1
> > @@ -346,6 +401,10 @@ struct optee_msg_arg {
> >  #define OPTEE_MSG_CMD_UNREGISTER_SHM 5
> >  #define OPTEE_MSG_CMD_DO_BOTTOM_HALF 6
> >  #define OPTEE_MSG_CMD_STOP_ASYNC_NOTIF       7
> > +#define OPTEE_MSG_CMD_LEND_RSTMEM    8
> > +#define OPTEE_MSG_CMD_RECLAIM_RSTMEM 9
> > +#define OPTEE_MSG_CMD_GET_RSTMEM_CONFIG      10
> > +#define OPTEE_MSG_CMD_ASSIGN_RSTMEM  11
> >  #define OPTEE_MSG_FUNCID_CALL_WITH_ARG       0x0004
> >
> >  #endif /* _OPTEE_MSG_H */
> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > index 879426300821..abc379ce190c 100644
> > --- a/drivers/tee/optee/optee_smc.h
> > +++ b/drivers/tee/optee/optee_smc.h
> > @@ -264,7 +264,6 @@ struct optee_smc_get_shm_config_result {
> >  #define OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM  BIT(0)
> >  /* Secure world can communicate via previously unregistered shared memor=
y */
> >  #define OPTEE_SMC_SEC_CAP_UNREGISTERED_SHM   BIT(1)
> > -
> >  /*
> >   * Secure world supports commands "register/unregister shared memory",
> >   * secure world accepts command buffers located in any parts of non-secu=
re RAM
> > @@ -280,6 +279,10 @@ struct optee_smc_get_shm_config_result {
> >  #define OPTEE_SMC_SEC_CAP_RPC_ARG            BIT(6)
> >  /* Secure world supports probing for RPMB device if needed */
> >  #define OPTEE_SMC_SEC_CAP_RPMB_PROBE         BIT(7)
> > +/* Secure world supports Secure Data Path */
> > +#define OPTEE_SMC_SEC_CAP_SDP                        BIT(8)
> > +/* Secure world supports dynamic restricted memory */
> > +#define OPTEE_SMC_SEC_CAP_DYNAMIC_RSTMEM     BIT(9)
> >
> >  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES       9
> >  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> > @@ -451,6 +454,72 @@ struct optee_smc_disable_shm_cache_result {
> >
> >  /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> >  #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG  19
> > +/*
> > + * Get Secure Data Path memory config
> > + *
> > + * Returns the Secure Data Path memory config.
> > + *
> > + * Call register usage:
> > + * a0   SMC Function ID, OPTEE_SMC_GET_SDP_CONFIG
> > + * a2-6      Not used, must be zero
> > + * a7        Hypervisor Client ID register
> > + *
> > + * Have config return register usage:
> > + * a0        OPTEE_SMC_RETURN_OK
> > + * a1        Physical address of start of SDP memory
> > + * a2        Size of SDP memory
> > + * a3        Not used
> > + * a4-7      Preserved
> > + *
> > + * Not available register usage:
> > + * a0        OPTEE_SMC_RETURN_ENOTAVAIL
> > + * a1-3 Not used
> > + * a4-7      Preserved
> > + */
> > +#define OPTEE_SMC_FUNCID_GET_SDP_CONFIG              20
>
> Let's have a consistent ABI naming here. I think RSTMEM is more generic
> rather than SDP, so let's use same naming convention as we use for FF-A
> ABI.

Yes, I'll fix it.

Cheers,
Jens

>
> -Sumit
>
> > +#define OPTEE_SMC_GET_SDP_CONFIG \
> > +     OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_SDP_CONFIG)
> > +
> > +struct optee_smc_get_sdp_config_result {
> > +     unsigned long status;
> > +     unsigned long start;
> > +     unsigned long size;
> > +     unsigned long flags;
> > +};
> > +
> > +/*
> > + * Get Secure Data Path dynamic memory config
> > + *
> > + * Returns the Secure Data Path dynamic memory config.
> > + *
> > + * Call register usage:
> > + * a0        SMC Function ID, OPTEE_SMC_GET_DYN_SHM_CONFIG
> > + * a2-6      Not used, must be zero
> > + * a7        Hypervisor Client ID register
> > + *
> > + * Have config return register usage:
> > + * a0        OPTEE_SMC_RETURN_OK
> > + * a1        Minamal size of SDP memory
> > + * a2        Required alignment of size and start of registered SDP memo=
ry
> > + * a3        Not used
> > + * a4-7      Preserved
> > + *
> > + * Not available register usage:
> > + * a0        OPTEE_SMC_RETURN_ENOTAVAIL
> > + * a1-3 Not used
> > + * a4-7      Preserved
> > + */
> > +
> > +#define OPTEE_SMC_FUNCID_GET_DYN_SDP_CONFIG  21
> > +#define OPTEE_SMC_GET_DYN_SDP_CONFIG \
> > +     OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_DYN_SDP_CONFIG)
> > +
> > +struct optee_smc_get_dyn_sdp_config_result {
> > +     unsigned long status;
> > +     unsigned long size;
> > +     unsigned long align;
> > +     unsigned long flags;
> > +};
> >
> >  /*
> >   * Resume from RPC (for example after processing a foreign interrupt)
> > --
> > 2.43.0
> >

--===============1171587130278204858==--


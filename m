Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40DD105F79A
	for <op-tee@archiver.kernel.org>; Fri, 13 Mar 2026 11:11:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1A8F243957
	for <op-tee@archiver.kernel.org>; Fri, 13 Mar 2026 11:11:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z+UZ/Y3u;
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1F86541882
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Mar 2026 11:11:32 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-466ec4c6846so703776b6e.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 13 Mar 2026 04:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773400291; cv=none;
        d=google.com; s=arc-20240605;
        b=gk+GUjHFVjqXcNFO84145z14jNjXw6ELI3DDBDmgZc4BpgVjhTbGE4ULiiBPK+e1C7
         0wwLcJ9Sc6EAE0ZMN6zQsug8OQ85AhHAW8InnR839yOld0026eQ3hfEjShK4WgI3nTlj
         Vb8CZOeaknQUADOPRvn+rSA6ddJ1mHCkAbl/SwyNuhUIezjyOxQmZ5q77hTa/jEkRiHd
         AbSxzsKs4WnjOxf7RZcz/8bW+5o9X/nplU7wa64a9psMwabTXddP5DNsX6jDFVsj/agm
         myNYRVJm23Abn6Mg7RjDlWvQmm4cR5y/WHBafZif8hrGbU6sme5t2HOSr6GdnBH84nL3
         BLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hGh/tnqgBROV2n4cJFccl69aa9hNxf7Ww/ANHVWYDhI=;
        fh=ZWzHRikvz9HC4EBSR7KCdYe+cpPrshLB+jmNMxkanLQ=;
        b=Pmzy9RQh3di2RPChLGvwC7RsgWM6zZh+KJ98b54kafifQ/79mC7l0I2ai7OSopx1Hn
         RL5/qSq83IatRQTlvaTtuNLwK3dfivcZGDRFpgAFr+UGIurRn56JlVWxSEUBphKB5W6O
         em3iJ2Yi4ngnOQzjqSqDDLSryybrJztsmyV9AAfi6RNooEt5hcdrGhk9+e9hm4CuTDDj
         6oQpJDapR2Kme9iuiw/KlAP9g659zgK0AnecNvAFi6VQJn5pOfkUDFZQk8DCKM+RpOa6
         ZY82B4G8LG8ENfKyL6sQRD1DUMAjYmWkHUWoapc1c347FbYbwR+lMSgqcW+y7dfloVjl
         77Mw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773400291; x=1774005091; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGh/tnqgBROV2n4cJFccl69aa9hNxf7Ww/ANHVWYDhI=;
        b=Z+UZ/Y3umqZm0z7ZACR8LeRdEh+6C4ofil9owtF+DkRo3khOdTLlerIwyoM8bmmgv5
         LUiRKoc0nn9PcnaavysjAvE1PwxhGgj5xo77q1lyjhoYpIxt5KF5N0gRF1ylYxi0oeoD
         vDFxyrfy/R2kuP5OZpWNxCIv9+DqMgsLcWZYHenHmmr6TSre/Dc3TsorMOkWPMfkOttl
         l3ouGz5GtVPjhRFOk0VBKX3GgyuH7d5LjRX+KszYQsNl6N8ihiwHgl6w71uHPSfkjOMe
         BqLWPdo06Z20jTpQFFIX41eyTbxNQPLMyvp+yRBBzlKvCbYX19e3flSpCd9TMtXazC1N
         xRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773400291; x=1774005091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGh/tnqgBROV2n4cJFccl69aa9hNxf7Ww/ANHVWYDhI=;
        b=QCvkqQkPDRVaZsDwbMgQf0T1xJWfGR2Mg5tKL0/fEFbW+IPiSQd+dOBg9R5NH5lELI
         Ewb+f4AdWqg5tjr8rf8MzGpfE2trQBmNpqcMUi+iQ/EowkEWYv+wgamPnhv6GJ7QvTee
         Re5Nk5ihbrL5HA9IFsqmNowribfmFLQTQ2s6svMtHwlltbVmUB+7JpkfLc83nuRu03KE
         u3f0K5xIsYZr+zoOby63892uvXkF15PaT6WT2kqDv2DMj24Wm8KcfokXOm6I+Xa2BHT6
         dKcYR0SXkNfEWd5dlVpkTUKLvPX0BRF30jcRjIYcpANExfbxI47cJQJ6rrpRAYz0YkHg
         Udlg==
X-Forwarded-Encrypted: i=1; AJvYcCWKvkJI4corcr1zSj5nB2JDjOu7UzxH14hQyt707AKF+BmNj0w/h+DRuVHFnPNLwk92L0TNw0s=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzZg2SCYY4BnhARaPDGeZbRFzwXdJlfmKlHwKYtJLWiiED3FzVJ
	rjASArJ+3sso5ZMQOlKbOndcQadVE0IrW/b1iOH1GBwIjscyoAQMCRwHYQFpR1K/5HbyHyv8KvY
	eujTuIZ/U4OBZ7A0T16piDt49BL4BFtXARMR4BtJZi0TZ
X-Gm-Gg: ATEYQzyo9/+AvzYOt1vvmhNoMrJRv12aIm6DV84EpxDk4rvEndMPDs87cvtYjruIJYc
	ofAFjEXLaf8rPOppo75ztpQiL1lcH374noJ+/7t/wQvNxhflLc765qzMqL+8Nqa4k4T82VlR7q3
	JtiUSQjbn9AcaYU5hoxIKGMut0yL4/A4Qa8b+QpU5olEpHeEe8Vv2Vt+v14AWg/vjHxqdXuPoC2
	UxLzG2qMfVxgvS/JMrA/w0lBHhL+QT3SRfjWPE2UuGjyioBgbVTVm0DEl+2gC9Zyml0aEGO4bS5
	9sYWNNTnk8Rp5qXh+g6ePI+h4Aypmm4ZuR9jbsWU7MMO1Nm8
X-Received: by 2002:a05:6820:f008:b0:661:13eb:6ce4 with SMTP id
 006d021491bc7-67bda9c0bcemr1813664eaf.21.1773400291340; Fri, 13 Mar 2026
 04:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260311052953.313121-1-rdunlap@infradead.org> <abKBvHRsJkeAm_Hq@sumit-xelite>
In-Reply-To: <abKBvHRsJkeAm_Hq@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 13 Mar 2026 12:11:19 +0100
X-Gm-Features: AaiRm52vIKIf7AmLH_7f85afXXwAfdkMA43wRJWH64v_ypb9rwkUGAQpkSkXtdM
Message-ID: <CAHUa44FaZHVa9ZvfrPEYU7Bn3B+BPMXkmSi5o62SPNwr1RdjCQ@mail.gmail.com>
Subject: Re: [PATCH] tee: clean up tee_core.h kernel-doc
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.179:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.179:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1F86541882
X-Spamd-Bar: -----
Message-ID-Hash: YDMOYODRGMMR6QLJLAC5IGT4KXITGBXP
X-Message-ID-Hash: YDMOYODRGMMR6QLJLAC5IGT4KXITGBXP
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YDMOYODRGMMR6QLJLAC5IGT4KXITGBXP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Mar 12, 2026 at 10:05=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Tue, Mar 10, 2026 at 10:29:53PM -0700, Randy Dunlap wrote:
> > Use the correct struct member name and function parameter name in
> > kernel-doc comments.
> > Move a macro that was between a struct's documentation and its
> > declaration.
> > These eliminate the following kernel-doc warnings:
> >
> > Warning: include/linux/tee_core.h:73 struct member 'c_no_users' not
> >  described in 'tee_device'
> > Warning: include/linux/tee_core.h:132 #define TEE_DESC_PRIVILEGED
> >      0x1; error: Cannot parse struct or union!
> > Warning: include/linux/tee_core.h:257 function parameter 'connection_da=
ta'
> >  not described in 'tee_session_calc_client_uuid'
> > Warning: include/linux/tee_core.h:320 function parameter 'teedev'
> >  not described in 'tee_get_drvdata'
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@kernel.org>
> > Cc: op-tee@lists.trustedfirmware.org
> >
> >  include/linux/tee_core.h |   30 ++++++++++++++++--------------
> >  1 file changed, 16 insertions(+), 14 deletions(-)
>
> Thanks for the kernel-doc warnings fixes, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > --- linux-next-20260309.orig/include/linux/tee_core.h
> > +++ linux-next-20260309/include/linux/tee_core.h
> > @@ -50,7 +50,7 @@ enum tee_dma_heap_id {
> >   * @dev:     embedded basic device structure
> >   * @cdev:    embedded cdev
> >   * @num_users:       number of active users of this device
> > - * @c_no_user:       completion used when unregistering the device
> > + * @c_no_users:      completion used when unregistering the device
> >   * @mutex:   mutex protecting @num_users and @idr
> >   * @idr:     register of user space shared memory objects allocated or
> >   *           registered on this device
> > @@ -132,6 +132,7 @@ struct tee_driver_ops {
> >  /* Size for TEE revision string buffer used by get_tee_revision(). */
> >  #define TEE_REVISION_STR_SIZE        128
> >
> > +#define TEE_DESC_PRIVILEGED  0x1
> >  /**
> >   * struct tee_desc - Describes the TEE driver to the subsystem
> >   * @name:    name of driver
> > @@ -139,7 +140,6 @@ struct tee_driver_ops {
> >   * @owner:   module providing the driver
> >   * @flags:   Extra properties of driver, defined by TEE_DESC_* below
> >   */
> > -#define TEE_DESC_PRIVILEGED  0x1
> >  struct tee_desc {
> >       const char *name;
> >       const struct tee_driver_ops *ops;
> > @@ -187,7 +187,7 @@ struct tee_protmem_pool_ops {
> >   * Allocates a new struct tee_device instance. The device is
> >   * removed by tee_device_unregister().
> >   *
> > - * @returns a pointer to a 'struct tee_device' or an ERR_PTR on failur=
e
> > + * @returns: a pointer to a 'struct tee_device' or an ERR_PTR on failu=
re
> >   */
> >  struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
> >                                   struct device *dev,
> > @@ -201,7 +201,7 @@ struct tee_device *tee_device_alloc(cons
> >   * tee_device_unregister() need to be called to remove the @teedev if
> >   * this function fails.
> >   *
> > - * @returns < 0 on failure
> > + * @returns: < 0 on failure
> >   */
> >  int tee_device_register(struct tee_device *teedev);
> >
> > @@ -254,14 +254,14 @@ void tee_device_set_dev_groups(struct te
> >   * tee_session_calc_client_uuid() - Calculates client UUID for session
> >   * @uuid:            Resulting UUID
> >   * @connection_method:       Connection method for session (TEE_IOCTL_=
LOGIN_*)
> > - * @connectuon_data: Connection data for opening session
> > + * @connection_data: Connection data for opening session
> >   *
> >   * Based on connection method calculates UUIDv5 based client UUID.
> >   *
> >   * For group based logins verifies that calling process has specified
> >   * credentials.
> >   *
> > - * @return < 0 on failure
> > + * @returns: < 0 on failure
> >   */
> >  int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> >                                const u8 connection_data[TEE_IOCTL_UUID_=
LEN]);
> > @@ -295,7 +295,7 @@ struct tee_shm_pool_ops {
> >   * @paddr:   Physical address of start of pool
> >   * @size:    Size in bytes of the pool
> >   *
> > - * @returns pointer to a 'struct tee_shm_pool' or an ERR_PTR on failur=
e.
> > + * @returns: pointer to a 'struct tee_shm_pool' or an ERR_PTR on failu=
re.
> >   */
> >  struct tee_shm_pool *tee_shm_pool_alloc_res_mem(unsigned long vaddr,
> >                                               phys_addr_t paddr, size_t=
 size,
> > @@ -318,14 +318,16 @@ static inline void tee_shm_pool_free(str
> >   * @paddr:   Physical address of start of pool
> >   * @size:    Size in bytes of the pool
> >   *
> > - * @returns pointer to a 'struct tee_protmem_pool' or an ERR_PTR on fa=
ilure.
> > + * @returns: pointer to a 'struct tee_protmem_pool' or an ERR_PTR on f=
ailure.
> >   */
> >  struct tee_protmem_pool *tee_protmem_static_pool_alloc(phys_addr_t pad=
dr,
> >                                                      size_t size);
> >
> >  /**
> >   * tee_get_drvdata() - Return driver_data pointer
> > - * @returns the driver_data pointer supplied to tee_register().
> > + * @teedev: Pointer to the tee_device
> > + *
> > + * @returns: the driver_data pointer supplied to tee_register().
> >   */
> >  void *tee_get_drvdata(struct tee_device *teedev);
> >
> > @@ -334,7 +336,7 @@ void *tee_get_drvdata(struct tee_device
> >   *                            TEE driver
> >   * @ctx:     The TEE context for shared memory allocation
> >   * @size:    Shared memory allocation size
> > - * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on =
failure
> > + * @returns: a pointer to 'struct tee_shm' on success or an ERR_PTR on=
 failure
> >   */
> >  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t=
 size);
> >
> > @@ -354,7 +356,7 @@ void tee_dyn_shm_free_helper(struct tee_
> >  /**
> >   * tee_shm_is_dynamic() - Check if shared memory object is of the dyna=
mic kind
> >   * @shm:     Shared memory handle
> > - * @returns true if object is dynamic shared memory
> > + * @returns: true if object is dynamic shared memory
> >   */
> >  static inline bool tee_shm_is_dynamic(struct tee_shm *shm)
> >  {
> > @@ -370,7 +372,7 @@ void tee_shm_put(struct tee_shm *shm);
> >  /**
> >   * tee_shm_get_id() - Get id of a shared memory object
> >   * @shm:     Shared memory handle
> > - * @returns id
> > + * @returns: id
> >   */
> >  static inline int tee_shm_get_id(struct tee_shm *shm)
> >  {
> > @@ -382,7 +384,7 @@ static inline int tee_shm_get_id(struct
> >   * count
> >   * @ctx:     Context owning the shared memory
> >   * @id:              Id of shared memory object
> > - * @returns a pointer to 'struct tee_shm' on success or an ERR_PTR on =
failure
> > + * @returns: a pointer to 'struct tee_shm' on success or an ERR_PTR on=
 failure
> >   */
> >  struct tee_shm *tee_shm_get_from_id(struct tee_context *ctx, int id);
> >
> > @@ -402,7 +404,7 @@ static inline bool tee_param_is_memref(s
> >   * teedev_open() - Open a struct tee_device
> >   * @teedev:  Device to open
> >   *
> > - * @return a pointer to struct tee_context on success or an ERR_PTR on=
 failure.
> > + * @returns: pointer to struct tee_context on success or an ERR_PTR on=
 failure.
> >   */
> >  struct tee_context *teedev_open(struct tee_device *teedev);
> >

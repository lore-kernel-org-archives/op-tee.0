Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B2CCF9E3
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 09:46:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8B93F50022
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 09:46:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=S960Md+/;
	dkim-atps=neutral
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B1BED43154
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 09:46:28 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c6cc44ff62so2133072a34.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762767988; x=1763372788; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpQaurzo67KxUNaUfM58zdtArAVNYjA4ClY5xFy4KPI=;
        b=S960Md+/Gzo0e88ARAFHs29fZZiQ/ux3l1Vrz18zQSrz1zygdOEgJjCFQnaLn5/qn+
         5jjUOm6DfMVRzBBv51thH8kKn6O2+CjAmJ2A6D8v5f1oB5uxNnyzGbxbCI7wZD3zRtge
         3HPiT9BRz5DqWRV9vAuPjw/VLZZMDXuSrREmlIEDBPBwnZuESNRFLAccuoA7X9NxPCIL
         daMpNUh97P5YwGKlROjeJau699x5V0HW8QFqj+iwV8USH93i8KMY/tSHOHCcuOLbsjWP
         ehOFKjooTasg5PsBl1zaOrhubStfCUG5SW+Cni0MQjal8GrJsuXCSqxmVm61ghvPKed6
         OnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767988; x=1763372788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpQaurzo67KxUNaUfM58zdtArAVNYjA4ClY5xFy4KPI=;
        b=T/fS1Z5+V1JN4jBOEodLRK5FMQQeYM8Z2dKm5NR1jU57aPwLA/oBFNhkoSCX8RuwC7
         FHLi2FnKFdHWSq2QciXuNIjWC1CdR4Z+SO6YGQ3SlKgebMg0ElYyVlprbm9zXqizJShh
         qLJVTDSAlZJW0/xhqOzahKpXz+aOIBpRcHeaRMy4UlR8P+pIxkze1pnayPh+bFc5kywS
         WrTW84vfy7lyRGU1LhxDPDtFmEIByhOo4LTCZ/b7upYp7i+ufq/u0VBh3I/fuOt/GcTH
         1ehKqpZuroHZZlyRsEWYTWQVa5YKLnLObYXTk+NDuTsomKOfBBqQSOaAZ9kRE17uShUV
         Um/w==
X-Forwarded-Encrypted: i=1; AJvYcCVID0TrLiuc5xPabA00G16mh4IkDJhmvzK0XU8egW0Ik2686ZQdwn8sXZaIh1zVsqCce2oT7P8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxEb7rWIX9zSi67i+q4ncPzC6CnNkaDrYnKWhDOmBcgn754JMJT
	F1As7N/BduLBR4kwza6lGIFc8W6kaqPZv+MlumorMil0J+wiiJAGGzsguqm5nBNhcX+kjsBDJNl
	nai0uCOvdHgnZBy58C5J83rKMazNC2HZE0iaaqDz1sXj7
X-Gm-Gg: ASbGncvyItl07fA/X9F3ryUCKLKRGHa9c4jaoJ83A4JBwxsZaUVqQO23V/MWg6YsxvP
	zFHSIPMlmDtBSvUFJhWHk7Q341mqrG9yRewSPfkXF4qgJFN+h+pXJDUC5zq0gBI6UUQxrC/P0KU
	ndL//Ix/Rj9HGouCsT4E6MmAC1O2BFUF3uJxg/FdlLurGr0k/2eC3PB/LXpdZ3VrzNlJDVcSww0
	Au80NK+y7lDX/jhEikjc2pDJrcshgeTv8y5xKUc1GClKmU2ZdYruc1uOFiRPsnAZKJewA==
X-Google-Smtp-Source: AGHT+IFmH8Uh4y6gtqai86qIqHt5uEOsGz3Va9tFoeXAycpCM+2DV5FWfARtb5KOmXgN1BSOeN6ctHKuVIQEbQjAz84=
X-Received: by 2002:a05:6830:6da0:b0:7a0:239:809f with SMTP id
 46e09a7af769-7c6fd730bc9mr4627780a34.11.1762767988096; Mon, 10 Nov 2025
 01:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20251024052102.635908-1-rdunlap@infradead.org> <aQNj_24YgDicCLOa@sumit-X1>
In-Reply-To: <aQNj_24YgDicCLOa@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 10:46:16 +0100
X-Gm-Features: AWmQ_bnEcCaaQUq4N0njI8uuGGE5Npz9y0Al5gMP4-EoSBPhEF-vFqf2yZLcNHM
Message-ID: <CAHUa44GU6jVwdSSkYW-QxhOJvqKrq_JTF-cW=435UiT+cgK-jA@mail.gmail.com>
Subject: Re: [PATCH] tee: <uapi/linux/tee.h: fix all kernel-doc issues
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B1BED43154
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.47:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.47:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: GYTZZPMYNJXZSU2G7A3CJGIKBAPTKWTA
X-Message-ID-Hash: GYTZZPMYNJXZSU2G7A3CJGIKBAPTKWTA
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GYTZZPMYNJXZSU2G7A3CJGIKBAPTKWTA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Oct 30, 2025 at 2:11=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Oct 23, 2025 at 10:21:02PM -0700, Randy Dunlap wrote:
> > Fix kernel-doc warnings so that there no other kernel-doc issues
> > in <uapi/linux/tee.h>:
> >
> > - add ending ':' to some struct members as needed for kernel-doc
> > - change struct name in kernel-doc to match the actual struct name (2x)
> > - add a @params: kernel-doc entry multiple times
> >
> > Warning: tee.h:265 struct member 'ret_origin' not described
> >  in 'tee_ioctl_open_session_arg'
> > Warning: tee.h:265 struct member 'num_params' not described
> >  in 'tee_ioctl_open_session_arg'
> > Warning: tee.h:265 struct member 'params' not described
> >  in 'tee_ioctl_open_session_arg'
> > Warning: tee.h:351 struct member 'num_params' not described
> >  in 'tee_iocl_supp_recv_arg'
> > Warning: tee.h:351 struct member 'params' not described
> >  in 'tee_iocl_supp_recv_arg'
> > Warning: tee.h:372 struct member 'num_params' not described
> >  in 'tee_iocl_supp_send_arg'
> > Warning: tee.h:372 struct member 'params' not described
> >  in 'tee_iocl_supp_send_arg'
> > Warning: tee.h:298: expecting prototype for struct
> >  tee_ioctl_invoke_func_arg. Prototype was for
> >  struct tee_ioctl_invoke_arg instead
> > Warning: tee.h:473: expecting prototype for struct
> >  tee_ioctl_invoke_func_arg. Prototype was for struct
> >  tee_ioctl_object_invoke_arg instead
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Sumit Garg <sumit.garg@kernel.org>
> > Cc: op-tee@lists.trustedfirmware.org
> > ---
> >  include/uapi/linux/tee.h |   23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
>
> Thanks for the fixes, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > --- linux-next-20251022.orig/include/uapi/linux/tee.h
> > +++ linux-next-20251022/include/uapi/linux/tee.h
> > @@ -249,8 +249,9 @@ struct tee_ioctl_param {
> >   * @cancel_id:       [in] Cancellation id, a unique value to identify =
this request
> >   * @session: [out] Session id
> >   * @ret:     [out] return value
> > - * @ret_origin       [out] origin of the return value
> > - * @num_params       [in] number of parameters following this struct
> > + * @ret_origin:      [out] origin of the return value
> > + * @num_params:      [in] number of &struct tee_ioctl_param entries in=
 @params
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_ioctl_open_session_arg {
> >       __u8 uuid[TEE_IOCTL_UUID_LEN];
> > @@ -276,14 +277,14 @@ struct tee_ioctl_open_session_arg {
> >                                    struct tee_ioctl_buf_data)
> >
> >  /**
> > - * struct tee_ioctl_invoke_func_arg - Invokes a function in a Trusted
> > - * Application
> > + * struct tee_ioctl_invoke_arg - Invokes a function in a Trusted Appli=
cation
> >   * @func:    [in] Trusted Application function, specific to the TA
> >   * @session: [in] Session id
> >   * @cancel_id:       [in] Cancellation id, a unique value to identify =
this request
> >   * @ret:     [out] return value
> > - * @ret_origin       [out] origin of the return value
> > - * @num_params       [in] number of parameters following this struct
> > + * @ret_origin:      [out] origin of the return value
> > + * @num_params:      [in] number of parameters following this struct
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_ioctl_invoke_arg {
> >       __u32 func;
> > @@ -338,7 +339,8 @@ struct tee_ioctl_close_session_arg {
> >  /**
> >   * struct tee_iocl_supp_recv_arg - Receive a request for a supplicant =
function
> >   * @func:    [in] supplicant function
> > - * @num_params       [in/out] number of parameters following this stru=
ct
> > + * @num_params:      [in/out] number of &struct tee_ioctl_param entrie=
s in @params
> > + * @params:  array of ioctl parameters
> >   *
> >   * @num_params is the number of params that tee-supplicant has room to
> >   * receive when input, @num_params is the number of actual params
> > @@ -363,7 +365,8 @@ struct tee_iocl_supp_recv_arg {
> >  /**
> >   * struct tee_iocl_supp_send_arg - Send a response to a received reque=
st
> >   * @ret:     [out] return value
> > - * @num_params       [in] number of parameters following this struct
> > + * @num_params:      [in] number of &struct tee_ioctl_param entries in=
 @params
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_iocl_supp_send_arg {
> >       __u32 ret;
> > @@ -454,11 +457,13 @@ struct tee_ioctl_shm_register_fd_data {
> >   */
> >
> >  /**
> > - * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted A=
pplication
> > + * struct tee_ioctl_object_invoke_arg - Invokes an object in a
> > + *   Trusted Application
> >   * @id:              [in] Object id
> >   * @op:              [in] Object operation, specific to the object
> >   * @ret:     [out] return value
> >   * @num_params:      [in] number of parameters following this struct
> > + * @params:  array of ioctl parameters
> >   */
> >  struct tee_ioctl_object_invoke_arg {
> >       __u64 id;

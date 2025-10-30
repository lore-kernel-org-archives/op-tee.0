Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164B9CCF9FC
	for <op-tee@archiver.kernel.org>; Thu, 30 Oct 2025 13:11:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2F514430FD
	for <op-tee@archiver.kernel.org>; Thu, 30 Oct 2025 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1761829903;
	bh=RAuD9U2XDmp39OPdTP0KWRm2i+jlT1G4sL2XCp8RTOg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AJaauUOOvwGKj3Tjtcu11Kem0yqRomxVfZ2LmIz4K9I9e03pnxsYAKlEYdJAzXael
	 AWTNchRhe4wAyZvX1CqQ2XZWvI7SQgSOIxXwEstxdDgdxmr0w/PlxoT2xNhhDrlAqc
	 K3GpsZ/PtVRjvcLiO59Cer04BDddP8MJa02vNJycI25xF7ExRgWEy/CzRPvTTCiqw6
	 ipyCCfemKMzcZNMhc70ks2ZCdCIGNb+d4etyrCIj9W6/bAQ8fRBUPTzzFueQXlRcq/
	 tth4jOy4bjiZIqyIDTKQgO/ywEGnexxHvLrbBxEW1jmiZti5ayfaruC7O/ZgTCL5Ck
	 2MqErSHQVmr9w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6FA4842F5F
	for <op-tee@lists.trustedfirmware.org>; Thu, 30 Oct 2025 13:11:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gXaka5zy;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EAB2B61D1E;
	Thu, 30 Oct 2025 13:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D7DC4CEFF;
	Thu, 30 Oct 2025 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761829891;
	bh=RAuD9U2XDmp39OPdTP0KWRm2i+jlT1G4sL2XCp8RTOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXaka5zyAyLBdMBkWOkfBtjx13poW/NiuVOs5NiM2lWHLQ2lDiNztq55Dv+wNWs6r
	 EHTuR+rahGnfcs4UNrUMIDD2Z4yiHvs3Jn9cCJrNo+lp1WwLTdQvhVl/8xHeGykOb2
	 TQUHjkxwadEG57bZ1/OdCl1Q81ubY82FZFCM643MuJcoprs7G+aNl83JAIyR61UDFi
	 tUN2WzqH4/zyR5XdXykqwiKoYrQfOK8iXefcsnG1n6LwXSrtGZXeDJX7mfJxpvVhzt
	 SAnQEwVLbCf+bJReUxbAVgXYsu4nOfjnnXVyccrLEuAvB9cfP/NWaBZQvAy+8Grmwm
	 TxvOOaoeGhfwg==
Date: Thu, 30 Oct 2025 18:41:27 +0530
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] tee: <uapi/linux/tee.h: fix all kernel-doc issues
Message-ID: <aQNj_24YgDicCLOa@sumit-X1>
References: <20251024052102.635908-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024052102.635908-1-rdunlap@infradead.org>
X-Rspamd-Queue-Id: 6FA4842F5F
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: EAOLTNXPWYTWGC3QBX4PXKH3CU6DJQBH
X-Message-ID-Hash: EAOLTNXPWYTWGC3QBX4PXKH3CU6DJQBH
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EAOLTNXPWYTWGC3QBX4PXKH3CU6DJQBH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Oct 23, 2025 at 10:21:02PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warnings so that there no other kernel-doc issues
> in <uapi/linux/tee.h>:
> 
> - add ending ':' to some struct members as needed for kernel-doc
> - change struct name in kernel-doc to match the actual struct name (2x)
> - add a @params: kernel-doc entry multiple times
> 
> Warning: tee.h:265 struct member 'ret_origin' not described
>  in 'tee_ioctl_open_session_arg'
> Warning: tee.h:265 struct member 'num_params' not described
>  in 'tee_ioctl_open_session_arg'
> Warning: tee.h:265 struct member 'params' not described
>  in 'tee_ioctl_open_session_arg'
> Warning: tee.h:351 struct member 'num_params' not described
>  in 'tee_iocl_supp_recv_arg'
> Warning: tee.h:351 struct member 'params' not described
>  in 'tee_iocl_supp_recv_arg'
> Warning: tee.h:372 struct member 'num_params' not described
>  in 'tee_iocl_supp_send_arg'
> Warning: tee.h:372 struct member 'params' not described
>  in 'tee_iocl_supp_send_arg'
> Warning: tee.h:298: expecting prototype for struct
>  tee_ioctl_invoke_func_arg. Prototype was for
>  struct tee_ioctl_invoke_arg instead
> Warning: tee.h:473: expecting prototype for struct
>  tee_ioctl_invoke_func_arg. Prototype was for struct
>  tee_ioctl_object_invoke_arg instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: op-tee@lists.trustedfirmware.org
> ---
>  include/uapi/linux/tee.h |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)

Thanks for the fixes, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> --- linux-next-20251022.orig/include/uapi/linux/tee.h
> +++ linux-next-20251022/include/uapi/linux/tee.h
> @@ -249,8 +249,9 @@ struct tee_ioctl_param {
>   * @cancel_id:	[in] Cancellation id, a unique value to identify this request
>   * @session:	[out] Session id
>   * @ret:	[out] return value
> - * @ret_origin	[out] origin of the return value
> - * @num_params	[in] number of parameters following this struct
> + * @ret_origin:	[out] origin of the return value
> + * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
> + * @params:	array of ioctl parameters
>   */
>  struct tee_ioctl_open_session_arg {
>  	__u8 uuid[TEE_IOCTL_UUID_LEN];
> @@ -276,14 +277,14 @@ struct tee_ioctl_open_session_arg {
>  				     struct tee_ioctl_buf_data)
>  
>  /**
> - * struct tee_ioctl_invoke_func_arg - Invokes a function in a Trusted
> - * Application
> + * struct tee_ioctl_invoke_arg - Invokes a function in a Trusted Application
>   * @func:	[in] Trusted Application function, specific to the TA
>   * @session:	[in] Session id
>   * @cancel_id:	[in] Cancellation id, a unique value to identify this request
>   * @ret:	[out] return value
> - * @ret_origin	[out] origin of the return value
> - * @num_params	[in] number of parameters following this struct
> + * @ret_origin:	[out] origin of the return value
> + * @num_params:	[in] number of parameters following this struct
> + * @params:	array of ioctl parameters
>   */
>  struct tee_ioctl_invoke_arg {
>  	__u32 func;
> @@ -338,7 +339,8 @@ struct tee_ioctl_close_session_arg {
>  /**
>   * struct tee_iocl_supp_recv_arg - Receive a request for a supplicant function
>   * @func:	[in] supplicant function
> - * @num_params	[in/out] number of parameters following this struct
> + * @num_params:	[in/out] number of &struct tee_ioctl_param entries in @params
> + * @params:	array of ioctl parameters
>   *
>   * @num_params is the number of params that tee-supplicant has room to
>   * receive when input, @num_params is the number of actual params
> @@ -363,7 +365,8 @@ struct tee_iocl_supp_recv_arg {
>  /**
>   * struct tee_iocl_supp_send_arg - Send a response to a received request
>   * @ret:	[out] return value
> - * @num_params	[in] number of parameters following this struct
> + * @num_params:	[in] number of &struct tee_ioctl_param entries in @params
> + * @params:	array of ioctl parameters
>   */
>  struct tee_iocl_supp_send_arg {
>  	__u32 ret;
> @@ -454,11 +457,13 @@ struct tee_ioctl_shm_register_fd_data {
>   */
>  
>  /**
> - * struct tee_ioctl_invoke_func_arg - Invokes an object in a Trusted Application
> + * struct tee_ioctl_object_invoke_arg - Invokes an object in a
> + *   Trusted Application
>   * @id:		[in] Object id
>   * @op:		[in] Object operation, specific to the object
>   * @ret:	[out] return value
>   * @num_params:	[in] number of parameters following this struct
> + * @params:	array of ioctl parameters
>   */
>  struct tee_ioctl_object_invoke_arg {
>  	__u64 id;

Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26569EA8553
	for <op-tee@archiver.kernel.org>; Mon,  9 Mar 2026 05:04:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6F054438A7
	for <op-tee@archiver.kernel.org>; Mon,  9 Mar 2026 05:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773032668;
	bh=nlljNcMEmbBFbwMlFYIHGVsIVpYN3RV0Ax1svPiwBxc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Hlax1+2TjxYWiaLhglPt/eGCWjGEuFXyKKPLqcTkTI4uIZHQeQvIgC8nql+9i4jmk
	 mvs2waNJeGZTHBCh5bXGeYxtHZgVS7rmwCbo7/x9+Ia54oQXKTR9nA+x6K5yVSGgVR
	 4mQ2CRnz6qIKgcEWm/TM3Hepc7rgdvMvDqvwM7iZYICUT2Gobdsukdl5FR2Irhk3BR
	 CbC/uJMYiI/zErIpLEmmj/Ov/VEt9llG8xSzqOrvfW9c3xAp/7QlLQr+RHuyg9EbGl
	 1cI8PSe/udfvg21Vr2NfXhBDxkh1FZZK2X2Nwddmu0ZFkEVereZchjz2PFxliQEGi1
	 6MgoJ7wCZF/+w==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6D20943847
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Mar 2026 05:04:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kifEbwgH;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 994F740B34;
	Mon,  9 Mar 2026 05:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F1CC4CEF7;
	Mon,  9 Mar 2026 05:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773032648;
	bh=nlljNcMEmbBFbwMlFYIHGVsIVpYN3RV0Ax1svPiwBxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kifEbwgH38BQFm5WxRPTeN3CNvd4K+gkDSR75UnwaDfst+kFhLsxDZG1gwvv0J2zV
	 niepDzatZrDdxCyHDXvhhEYaaQDTaD9gHpvogArXx689+0dN/J0l163W+YpD1I7TTg
	 KoowqFeMkUjngRi6nIIGr6ofrkDkLXrijpMGjI44dDeljAI41dks9IHL49Qcbc2Jtx
	 EsgvJI3bOn0gaQgOvxo+NlrKVhm8I++VaArWtdCGv7V3J5RxvyJ0DpEE0gVbE3av+F
	 YXcofqmqvy7VrQqhyw3fGViE5VGK9u0SxRxFRyCohcNvIvvlghkKvcJ8/a4adVDxJr
	 2HH0J6B12cKPg==
Date: Mon, 9 Mar 2026 10:33:49 +0530
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
Message-ID: <aa5UtcfiIe78oj1S@sumit-xelite>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <00a7e65d-aad3-4029-af51-ff0870e65595@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a7e65d-aad3-4029-af51-ff0870e65595@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6D20943847
X-Spamd-Bar: --
Message-ID-Hash: 4PLS7PCWYX7RVL4JGSYJELUASMYMSR4B
X-Message-ID-Hash: 4PLS7PCWYX7RVL4JGSYJELUASMYMSR4B
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.
 qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4PLS7PCWYX7RVL4JGSYJELUASMYMSR4B/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Mar 06, 2026 at 07:49:07AM -0800, Jeff Johnson wrote:
> On 3/6/2026 2:50 AM, Sumit Garg wrote:
> 
> I missed one k-doc warning...
> 
> > +/**
> > + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
> 
> s/scm_//
> 
> Warning: drivers/firmware/qcom/qcom_pas.c:173 expecting prototype for
> qcom_scm_pas_auth_and_reset(). Prototype was for qcom_pas_auth_and_reset() instead
> 

Thanks for the k-doc warnings report, I will fix them in the next
version.

-Sumit

> > + *				   and reset the remote processor
> > + * @pas_id:	peripheral authentication service id
> > + *
> > + * Return 0 on success.
> > + */
> > +int qcom_pas_auth_and_reset(u32 pas_id)
> > +{
> > +	if (ops_ptr)
> > +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> > +
> > +	return -ENODEV;
> > +}
> 

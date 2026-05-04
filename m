Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE8CFF885A
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 11:28:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 03D9244E0B
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 11:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777894085;
	bh=vmwhKpIuJ/kZwCXjcaFmLTe8fKVmq6dYhXjPDXJ2dss=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yQA2OmZLlbJdZF1TgQ9QNP8F7yjrm/QMGkV++iRo0QGnSelebs+F1P+LB4QOaQFKL
	 c9c/lRzpSnPZ5sFOxfM1L4N5EkMyWU2ogIfvIzT5qC3bTbVOLO535mVpy6AiUrbCFZ
	 if2yR+MydRgL7V0RTxAoYfrkUNOR96j20HJl+9sibpOGiWBGXKRoF2HRIXAztOyzAZ
	 8tEZauuArm2GiDAxo/atycAKCAJKHaMLMsnxDQx+br8GveLLZh73moCliZRhYYxgN7
	 azNLqchgkKpyhAyrWipbEPgblvv6Y2/xWVHbUpHEnAb/zQlrU07TpbsZwtF6eO9eyN
	 kPdjs2VxWBQwQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 732D343200
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 11:27:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=A8pMY5gA;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DB137435E8;
	Mon,  4 May 2026 11:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6DCC2BCB9;
	Mon,  4 May 2026 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777894077;
	bh=vmwhKpIuJ/kZwCXjcaFmLTe8fKVmq6dYhXjPDXJ2dss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8pMY5gALGtg1xGJyZawkZqX7NzKmzo4hhJUD7PMuWFYqDT8DYoMLbSATCHNzy+9j
	 9pzpd9WM9PXAQ+qliFpwwott2DWy2pCyXdx5Pw7lqK3jbHhf1CT65KX7rWU5Cw0MIc
	 sd8rLoBV6+GFdaDmgxzjH9jwRFlBKMUpt6nmcM3IcrwXVlCgYr+0etwE0BZvRLMz+b
	 8klOVo3i4ybTG3ezMXQ+iQ5THKHKoQEMA6oGmz/eHqqXBbEiXLOVss8ditfDjE6JuP
	 tpjWuBpj+w4SeVFI9wVqlnmhjC0SfO4TRkmpW6BSmb6MzURpeP0INtWUP8lduNUb2T
	 mLFJIqtsD3TIw==
Date: Mon, 4 May 2026 16:57:40 +0530
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
Message-ID: <afiCrIYSm8AK9xn9@sumit-xelite>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
 <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 732D343200
X-Spamd-Bar: -
Message-ID-Hash: ADZY7YCXNVKMLYCPEWKQC5RB5YPPR6KX
X-Message-ID-Hash: ADZY7YCXNVKMLYCPEWKQC5RB5YPPR6KX
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ADZY7YCXNVKMLYCPEWKQC5RB5YPPR6KX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, May 04, 2026 at 03:33:06PM +0530, Harshal Dev wrote:
> Hi Sumit,
> 
> On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Add support for Peripheral Authentication Service (PAS) driver based
> > on TEE bus with OP-TEE providing the backend PAS service implementation.
> > 
> > The TEE PAS service ABI is designed to be extensible with additional API
> > as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> > extensions of the PAS service needed while still maintaining backwards
> > compatibility.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  drivers/firmware/qcom/Kconfig        |  10 +
> >  drivers/firmware/qcom/Makefile       |   1 +
> >  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
> >  3 files changed, 490 insertions(+)
> >  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
> 
> [...]
> 
> > diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
> 
> > +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
> > +				  phys_addr_t addr, phys_addr_t size)
> > +{
> 
> [...]
> 
> > +
> > +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
> > +	if (ret < 0 || inv_arg.ret != 0) {
> > +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
> > +			pas_id, ret, inv_arg.ret);
> > +		return ret ?: -EINVAL;
> 
> Following the example from qcom_scm_pas_mem_setup() here:
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778
> 
> I think it should be:
> return ret ?: inv_arg.ret;

inv_arg.ret return a GP TEE error code which doesn't map 1:1 to kernel
error codes. The client drivers won't benefit without having a way to
decode those errors. So just printing here can help the user to debug
any issues.

> 
> This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
> I can see that is tries to print this error:
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286
> 
> With that,
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> 

Thanks, I hope with above I can keep your tag.

-Sumit

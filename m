Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10640CD343F
	for <op-tee@archiver.kernel.org>; Mon, 18 May 2026 05:47:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4AD1044DD0
	for <op-tee@archiver.kernel.org>; Mon, 18 May 2026 05:47:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PMwfzLUI;
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C2CE943702
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 05:23:40 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c801b30188dso3925293a12.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 14 May 2026 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778822620; x=1779427420; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GpC4Sy2ohSEgf27E/5DP9PBOmyJ/jHfS/ZObuxuM5HM=;
        b=PMwfzLUIMc9KcwA25AVyx/ECV1HpCCb9Yyov6K2B38KSZhU9VcdrGgBG9eJwFVstr1
         yPjz5f7IRtyirCyCAMnXcSvumpHUy4K8R+4F5EBA8ZzzzT7gJ2/RdPXXgf47FSmhc+WR
         czL3DlPsVSo3qY5KMC69V/WFvg/hzeirE8+Qkg4ffo/wfMHY2ChcVqXlWOika/8d9A+Q
         Dy6zTnBqZFL7PAXyA6UOgnetyjMdg79K2qPl9mbzY3CHvDlvhYNNhmNwjLQcvEz8xhpZ
         2Brvh8K/OiMgnfNIe3L67gEuojtnyjEKgPP/zpjDQ3Hor4u7sPDrXpFmmYDebA0E+M5d
         ACkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778822620; x=1779427420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpC4Sy2ohSEgf27E/5DP9PBOmyJ/jHfS/ZObuxuM5HM=;
        b=X2DcpDzx8KKK4DU2zGWuMEyBTuEvbCT55goTalq6pewRvpGLAhVJiX0ljHJ2JEKgXK
         /mF7vtjVoi2Xbg1e87g0hi7cryy+PSdC4+mo3EBfepV2cdnLjnj0OZsFldN6+5nZyRJQ
         gvLaDmt+SMQ0W21XNpS/Uqrw1kI7czubW4plPxjyYkR6xPNOvh7Si225StEJ2cy2oWkk
         MLIk4sg0y7kN9utJh6n+WWlUOLN4o0x/oPRijNb3SoarVILHywNsRMS5QtjZV8w7Cm8e
         HAHFapOBBFHt6USi4FVSWaiDwzKgNwK9+dGhpKhioNdtcCX13js0499OKX/RkmAx4Vgs
         JrLA==
X-Forwarded-Encrypted: i=1; AFNElJ9VtDjhf15xFVkscfqDI9ACApjBkz5Xq6KbMjILuIfNBdaIqSL8+oz83ceX5NM9aQvnRMB3Q1w=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxvqAJFLccyUF14R82CiwRGVZTaN/uoouczs4LLFIRp7Uetsd8b
	hC5HDlzNrZcOpSm0IPe4j48WcZ1wDegQFPr010+4pNLIJ04cLETuno36
X-Gm-Gg: Acq92OHSRje/CnujtskGUJrEBipvLa1D2rUlpMe/EwFGNO7J10hasDHo2BIg1o64Ezs
	DdfZKRdzx2nnxMD4k3ATLDZ94LjcAKiGupJNj95CJ9LuhBlDWXTLP6RVoUrG76JDS+w4/XiAPTt
	Y+/XDilGQlXBpYZnKwQf4LGq3F3pNHeBMSA7B58y6nVc6XDRfx0tf/cG9pQVflERsOr4H/9SuOS
	CMFUbXxgBC2GOJu7IF6QPMgMhFqEPoQ2DXqn9PkfOQBwDtLoiDL+L7MxFhVTSotUF0W9/sLUlyL
	laJbPsYxiCG6GxlqiN5oW/ICqLpumyidtK9W/g2Ukcrp5iN3Q2IEsBYeqYJnucAZAkKrbj9352i
	iBA+HlRXFW5L5d1863vugMd5UIrj0eRUIKhedisOEx85v16SYwVj9Uc13AmFvXl6SNwXBzrhyDg
	0XTs6fI24NBl+6A1irE6mZyvH6hGM=
X-Received: by 2002:a05:6a00:2a08:b0:82f:72e6:ed4 with SMTP id d2e1a72fcca58-83f33a18fcdmr2722540b3a.0.1778822619721;
        Thu, 14 May 2026 22:23:39 -0700 (PDT)
Received: from soyboi ([2402:8780:1073:dc10:22f6:2ac0:a51b:5d77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm4766005b3a.0.2026.05.14.22.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 22:23:39 -0700 (PDT)
Date: Fri, 15 May 2026 12:23:34 +0700
From: Robertus Diawan Chris <robertusdchris@gmail.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH] tee: qcomtee: add missing va_end in early return
 qcomtee_object_user_init()
Message-ID: <agat1sBHqkGWKzOD@soyboi>
References: <20260513091031.145826-1-robertusdchris@gmail.com>
 <8182784b-b6c2-4136-af8d-3aea4f5a4662@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8182784b-b6c2-4136-af8d-3aea4f5a4662@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.215.173:from];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.173:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C2CE943702
X-Spamd-Bar: ---
X-MailFrom: robertusdchris@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: NQATCFUOKS4F4ROSBKVCYMLZ6WU3DLEG
X-Message-ID-Hash: NQATCFUOKS4F4ROSBKVCYMLZ6WU3DLEG
X-Mailman-Approved-At: Mon, 18 May 2026 05:47:16 +0000
CC: sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org, me@brighamcampbell.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NQATCFUOKS4F4ROSBKVCYMLZ6WU3DLEG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Amir,

On Fri, May 15, 2026 at 11:31:50AM +1000, Amirreza Zarrabi wrote:
> On 5/13/2026 7:10 PM, Robertus Diawan Chris wrote:
> > qcomtee_object_user_init() is a variadic function and when the function
> > return because there's no dispatch callback in QCOMTEE_OBJECT_TYPE_CB
> > case, there's no va_end to cleanup "ap" object initialized by va_start
> > and that can cause undefined behavior. So make sure to use va_end before
> > returning the error code when there's no dispatch callback.
> >
> > This is reported by Coverity Scan as "Missing varargs init or cleanup".
> >
> > Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> > Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
> > ---
> > I don't have the device, so I am not sure how to test this change.
> > Thank you.
> >
> >  drivers/tee/qcomtee/core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> > index b1cb50e434f0..901a31e8201f 100644
> > --- a/drivers/tee/qcomtee/core.c
> > +++ b/drivers/tee/qcomtee/core.c
> > @@ -306,8 +306,10 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
> >  		break;
> >  	case QCOMTEE_OBJECT_TYPE_CB:
> >  		object->ops = ops;
> > -		if (!object->ops->dispatch)
> > -			return -EINVAL;
> > +		if (!object->ops->dispatch) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> >
> >  		/* If failed, "no-name". */
> >  		object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
> > @@ -320,6 +322,8 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
> >  	default:
> >  		ret = -EINVAL;
> >  	}
> > +
> > +out:
> >  	va_end(ap);
> >
> >  	return ret;
> >
> > base-commit: 5d6919055dec134de3c40167a490f33c74c12581
>
> Hi,
>
> Forgot to mention: how about using a break instead of a goto.

Oh right. In this case, using "break" statement is enough. I will send
the v2 of the patch. Maybe something like this:

	if (!object->ops->dispatch) {
		ret = -EINVAL;
		break;
	}

and then remove the "out" label.

> Then feel free to add Reviewed-by.

I want to confirm first, if I changed the patch using "break" statement,
do I need to add "Reviewed-by" tag in the v2 of the patch or not? I am
still not sure when to add "Reviewed-by" tag, like can we add
"Reviewed-by" tag when we changed the patch?

Thank you.

Best regards,
Robertus Diawan Chris

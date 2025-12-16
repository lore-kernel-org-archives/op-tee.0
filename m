Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49259D5B161
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 07:48:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 88A4D4FF15
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 07:48:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uIUbM4Tj;
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2B80D4FEDF
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 07:48:32 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so2603763fac.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 23:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765871311; x=1766476111; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frKHPX5ywrYd/FCcOy5yUMER90cU/9Dl+nl5fOqZwf8=;
        b=uIUbM4TjaG0by1krVzDsA9zl/cMcBpAk/MjBAUY2MGWXhqyg/0e8+RKms3qNY++vP7
         hWtHyQXJw6hvjod6sj+bpr9Dqg4QQbCfUnDuGF/igWG4NGMISM5AoTJjc5+TKDMDsYOd
         965hLHGe80VDG6oHGbKB+xjiN4dyHomNW9l4hk8KqMU+dg5Q6HU77gxvqM7uWApaENXh
         W3sutCdmDG8Z2Q2yl2l6lW3xgmIGjzQAQ5I/b8VkwSek8L8mhnCZs7q0dvXNh4Piuo0D
         VxTwa1NgvjZFJd/QX3gXClV6dRhllIEgz0pDKURBKuGxLG0ioH3e9V6vT7ho8NZf3Dkj
         jTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765871311; x=1766476111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frKHPX5ywrYd/FCcOy5yUMER90cU/9Dl+nl5fOqZwf8=;
        b=YNP4CbQu6t9DkI91kQC+xclJ6c9vjjAbzjTvjct2HJAs+n2KPepv8MqaV/S09KyqMa
         EIUUyesED8nQe6rzXTjDhMU8uMR/xxS+xm5xm+fjJeCIN1lWrUktw+arTH9zWPCuTT6i
         79wZ0I9zUa2t+P523gszB0Ut7shXwIdcwx5Y2V0vnmqufKGkyO9LgyAcEqfd2hMN9JB0
         GrirPIXgaKV3gKWJgeWJRAKRgZ/92wKC3/hYuhIUAROyyp9DKT4jAllmgoxQ4VCa7Yp9
         osgWwBT0R2Hpxosn4BLdQtXeYOd2STspLYet+yVdgB6U488vxFjdJiTzacL8xKLKWFVO
         t9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWUb2d5Wq083OG/hVyd1TG0KCYf7iFMcA5yiRWuJdvk7wgz4n+kyxM4E6blY5Td89lIptD4cFM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyaxoKkF0p4gFF9dYdRb00FXZ99GRTwsnWWkTcaRcY7o+3tmVxj
	7s7MA+VDP96fGUovEEd3yTy2zariOAbN6aM+/OZnEFbRQd3vHY5YrP/o6+wEkYk6cNAOwvxV2O0
	c2k1B3GHRZ3Y5JnZYxpS8JNR/7uNO8WgZhFBIWCJg0FYL
X-Gm-Gg: AY/fxX5YFrHt3IYeeB2yfO4zDMrdOZ7V/6ssGtLVbPLO1VJZJhhqRAFzot3mqUkcz/k
	EXiINavXXR8ko5IzyC7UC7udHw/KPcTAWDWrGP1by1Z2RxpODYo9T2XGBtY4W4ujckWQ193fGDu
	PJcII+/fWfdttTzxUpfU/7zA9+oGIBJ4A8CMY1zIYLTJaC44NYdBF1dWl147IIMTC3MEHoQVtU3
	5g4u2Em/L9bpiq44C/fyJBorKVL1CymPTafZEIIcek+aiDWAG0PvwVVSJPfPYQUYDW8/oKGAg9T
	zX2exj4cZgQBSHPHyYfkp/7UXg==
X-Google-Smtp-Source: AGHT+IEPOrKRWGgu+OxdDtx4IXb/qFP/j2ZNORsdxOva2CcQ8h0GLVsvgak9Sq1RKOKGOEcea3C4ZEcZYByXnUuFT0g=
X-Received: by 2002:a05:6820:f021:b0:659:9a49:8f9d with SMTP id
 006d021491bc7-65b451b5949mr6140936eaf.22.1765871311449; Mon, 15 Dec 2025
 23:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20251204101730.1036671-1-arnd@kernel.org> <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com> <aTbCqyOuprPOyU4X@sumit-X1>
 <2c0d09b7-0d8c-4bf2-a1bd-1dc4b58cd0a8@oss.qualcomm.com> <3aacf997-3a21-4e4b-b6bd-c55c36fb4c74@oss.qualcomm.com>
In-Reply-To: <3aacf997-3a21-4e4b-b6bd-c55c36fb4c74@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 16 Dec 2025 08:48:19 +0100
X-Gm-Features: AQt7F2oK7tpsUtSf_m-ZV3B6e3UN6ZLzybBTQt7InLkT3ExTm7qpHEoEcmffuZA
Message-ID: <CAHUa44GO-D1YcQ_36pe-vQ83fB9rcOkny+M7a=CThAxWb6TLTQ@mail.gmail.com>
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.46:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.46:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2B80D4FEDF
X-Spamd-Bar: ----
Message-ID-Hash: GMS34SD5X6DCK6I35ODDIFPXKM3Y3BBN
X-Message-ID-Hash: GMS34SD5X6DCK6I35ODDIFPXKM3Y3BBN
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GMS34SD5X6DCK6I35ODDIFPXKM3Y3BBN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Tue, Dec 9, 2025 at 4:54=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 12/8/2025 11:54 PM, Harshal Dev wrote:
> >
> >
> > On 12/8/2025 5:50 PM, Sumit Garg via OP-TEE wrote:
> >> On Mon, Dec 08, 2025 at 04:24:17PM +1100, Amirreza Zarrabi wrote:
> >>> Hi,
> >>>
> >>> On 12/5/2025 12:27 AM, Jens Wiklander wrote:
> >>>> Hi,
> >>>>
> >>>> On Thu, Dec 4, 2025 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@kernel.o=
rg> wrote:
> >>>>>
> >>>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>>>
> >>>>> The tee_ioctl_object_invoke_arg structure has padding on some
> >>>>> architectures but not on x86-32 and a few others:
> >>>>>
> >>>>> include/linux/tee.h:474:32: error: padding struct to align 'params'=
 [-Werror=3Dpadded]
> >>>>>
> >>>>> I expect that all current users of this are on architectures that d=
o
> >>>>> have implicit padding here (arm64, arm, x86, riscv), so make the pa=
dding
> >>>>> explicit in order to avoid surprises if this later gets used elsewh=
ere.
> >>>>>
> >>>>> Fixes: d5b8b0fa1775 ("tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF")
> >>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>>>> ---
> >>>>> The new interface showed up in 6.18, but I only came across this af=
ter
> >>>>> that was released. Changing it now is technically an ABI change on
> >>>>> architectures with unusual padding rules, so please consider carefu=
lly
> >>>>> whether we want to do it this way or not.
> >>>>>
> >>>>> Working around the ABI differences without an ABI change is possibl=
e,
> >>>>> but adds a lot of complexity for compat handling.
> >>>>
> >>>> This is currently only used by the recently introduced qcomtee backe=
nd
> >>>> driver. So it's only used on a few arm64 Qualcomm platforms right no=
w.
> >>>>
> >>>> I think we should take this patch, but let's hear what others think.
> >>
> >> Yeah since it's not an ABI issue on arm64 platforms where QTEE runs, s=
o:
> >>
> >> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>
> >>>>
> >>>> Thanks,
> >>>> Jens
> >>>>
> >>>
> >>> I agree. We should take this patch. As noted, there are not many
> >>> clients relying on it yet, so updating the userspace should
> >>> be straightforward.
> >>
> >> You should rather test without any userspace library update to test it=
's
> >> not an ABI issue. Just for correctness sake, you can update the librar=
y
> >> too.
> >>
> >
> > I'll take the time to test it at some point this week both with and wit=
hout updating
> > the library ABI.
> >
>
> Summit, that was the plan from the beginning, that's why I did not add "R=
eviewed-by:"
> in the first place. Thanks Harshal for volunteering.

Are we good with this patch now?

Cheers,
Jens

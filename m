Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6600BCCF9E3
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 09:00:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 97BF74FF05
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 09:00:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hJOk5gD0;
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DDE3241B8B
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 09:00:27 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so1790189fac.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762765227; x=1763370027; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtSKlm7YttYfRKSUOKAW4Fd5w28ivQq+HkbJeaaFeDY=;
        b=hJOk5gD0q9GT5n6enbCtIlxOnpNNp9HVZVYMUYpSbD9PfLsGItCS2Lt4ShRA89nmFb
         vinY+oKG1By1YdpatIII/IxkNoPcYfWW4Ju7/J7uLvXx1v7IkciQ+qXIWyjfDkkrAYpG
         4nxYwZ2+hZF7S6pYnphCa0BVtBtF3alt175egvFwwMcGOL2JuFcXyJPhgk0epeVL1T7T
         5wvStumF5m7q702pxpm/JfEZP9tQqc+6EVBZR/k/vIiH5h6U2uKkuH2TjuoaF/qKo1B+
         jkqR3CiD5j6+W4yTqeYR6kwTaMvMzzFRa8QBtR6ThiycNj/tlIEp38Ns51rwRTzTPPOe
         BRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765227; x=1763370027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtSKlm7YttYfRKSUOKAW4Fd5w28ivQq+HkbJeaaFeDY=;
        b=UfK8yM33dTG3+nC+v12DV1v393gEMJjAZXxB5j+pnUXOe7UsXrj/kjqdDuoN6QYdlO
         rb1BVQBZnyL7nUrLYAZd8qz/EwL6u0Ef9+BzhPkb1Ahi3sck5IuCHJOi5rCacWi98CXY
         B4EXYamOQ0TT486qPK8CoO7V68Duj4ZIiAdeIh2+jKWkRIfByQHpBSAKU6cQmvGStmmE
         9vyFO+hfspKKiJH2QNCi072jjZ4+l30DH02wzT3Xdi0XpiljGY/d0zbhYqL7o9rystot
         cEznUtYrDCAR1BPItUFcXeHp8C6oLlFWxEOMm3BsPZiZyuqtGtUkHmLKSGPWrnnBBHJZ
         yIJw==
X-Forwarded-Encrypted: i=1; AJvYcCV56gGRJKWOwFoIfzxlVLprLZhxpmvTXXIhIQ6WYNL+V32zndY4vydjUEWmfTJsqKAdIeLebcQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxkrqZKUcuuiYVVG1Z5S5SGp8S6qL6GbTwiyIXyo6SMgZVhF9sy
	3pIvNlkpmc2HU34GCnXCtMg1KMSBJTDQJFlwS0fbAkQHVYeZqO+Y5GhZkORtGPXCb82ge0YRvTG
	sSfo2QNM7WPrAOWSu390yLXWh8XKPDPGLDehNYPqnDeseo5SI4wcz2+e8OA==
X-Gm-Gg: ASbGnctwpYI5SQzXD7QzSzg95AE4RkpYZhAbr/65vzGmo0qayYO1p+jvCUFjc62Nd4h
	96erfMZyd7q+T0gloRnGOK1Q11g8bdweOUcqLzoCPz2KTkEYYxLMQAPwShWPYUrqPenXD55L3O8
	iTb6oTZgZs1YdoFZxOCw4zt+eRx9q7+l8G+nMdv4jBPXkYILxTrxSiZJiejv+ayv1t6H7Fnb7X0
	lI37P3BJGPv88zCdiJXMEiKf+NKwoVmyUGQf7kx0RrnhztPPTVFFxEwxFTbyTp0gLKMtA==
X-Google-Smtp-Source: AGHT+IH6R+If4MvL3Xf+Mrt1abrWP908OvG62tqCs76OiWY3NhnlNDpMOp7FYUb2RJMWzw69n6hBSFIbesOQpaQE3iQ=
X-Received: by 2002:a05:6870:e38e:b0:3d3:740e:d5fd with SMTP id
 586e51a60fabf-3e7c24744fdmr4152645fac.8.1762765227106; Mon, 10 Nov 2025
 01:00:27 -0800 (PST)
MIME-Version: 1.0
References: <aMvWAiMky0k4nHlh@stanley.mountain>
In-Reply-To: <aMvWAiMky0k4nHlh@stanley.mountain>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 10:00:15 +0100
X-Gm-Features: AWmQ_bmjwS14tQbNVA3wBvaZ3Fqm-eK7Hl03X7Va0p3RHqq7EP0j2nh7Ec3uMvg
Message-ID: <CAHUa44H2sdMdQ31dzgvnGDtP8A95pOVKew3nYGVEhYDXSm1Xig@mail.gmail.com>
Subject: Re: [bug report] tee: add Qualcomm TEE driver
To: Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DDE3241B8B
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-2.99)[99.95%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.49:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.49:from];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: JU2C56GVEFSK6BKQGGYUG2TQS55JWYFC
X-Message-ID-Hash: JU2C56GVEFSK6BKQGGYUG2TQS55JWYFC
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JU2C56GVEFSK6BKQGGYUG2TQS55JWYFC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Sep 18, 2025 at 11:51=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> Hello Amirreza Zarrabi,
>
> Commit d6e290837e50 ("tee: add Qualcomm TEE driver") from Sep 11,
> 2025 (linux-next), leads to the following Smatch static checker
> warning:
>
>         drivers/tee/qcomtee/core.c:104 qcomtee_do_release_qtee_object()
>         error: uninitialized symbol 'result'.
>
> drivers/tee/qcomtee/core.c
>     81 static void qcomtee_do_release_qtee_object(struct work_struct *wor=
k)
>     82 {
>     83         struct qcomtee_object *object;
>     84         struct qcomtee *qcomtee;
>     85         int ret, result;
>     86
>     87         /* RELEASE does not require any argument. */
>     88         struct qcomtee_arg args[] =3D { { .type =3D QCOMTEE_ARG_TY=
PE_INV } };
>     89
>     90         object =3D container_of(work, struct qcomtee_object, work)=
;
>     91         qcomtee =3D tee_get_drvdata(object->info.qcomtee_async_ctx=
->teedev);
>     92         /* Get the TEE context used for asynchronous operations. *=
/
>     93         qcomtee->oic.ctx =3D object->info.qcomtee_async_ctx;
>     94
>     95         ret =3D qcomtee_object_do_invoke_internal(&qcomtee->oic, o=
bject,
>     96                                                 QCOMTEE_MSG_OBJECT=
_OP_RELEASE,
>     97                                                 args, &result);
>     98
>     99         /* Is it safe to retry the release? */
>     100         if (ret && ret !=3D -ENODEV) {
>     101                 queue_work(qcomtee->wq, &object->work);
>     102         } else {
>     103                 if (ret || result)
> --> 104                         pr_err("%s release failed, ret =3D %d (%x=
)\n",
>     105                                qcomtee_object_name(object), ret, =
result);
>                                                                          =
^^^^^^
> result could be uninitialized if ret is non-zero.

Amir, please address this warning.

Thaks,
Jens

>
>     106                 qcomtee_qtee_object_free(object);
>     107         }
>     108 }
>
> regards,
> dan carpenter

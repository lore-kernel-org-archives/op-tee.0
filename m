Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94788606A331
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WXgsHAIw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RcfT8hHm
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E5FB1454A4
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:26:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WXgsHAIw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RcfT8hHm;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9BDE045493
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 15:25:54 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQB0i3644462
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 15:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=; b=WXgsHAIw4cd5PFjW
	lNmKFBgafI++UoKu7IynvRLi/wt+QVNg8ySrAgw8O3o35+zwrbp+bul4Z4PAN1Yj
	rjJKnkwqQkbm3cEIvFtNqVcN5f1eOU5pbJnrHNF7D8N5XYQUw2bpbtRs8I2TdFJG
	XpJh1UpmR+xQfx87Of4dPAw+VY2mcxDog4B90qKnrVr6+UWqjryVxh1SflOobBAF
	vH1fjqBhGQhjNGo0WMn7sRRzXep/lW3uyAXpRd3wRC2z9UUR2kiQV/7X0/KsmP4T
	HgFMnwIcqCDB5QW5FsIRrNjs0jkzBxl6B/yxQ4KKr9H5Isw4dfnFF30HR/xD29Kv
	F7jgqQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkds442-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 15:25:53 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8ab43f7f5faso35690017b3.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 07:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892352; cv=none;
        d=google.com; s=arc-20260327;
        b=WkTA8qfCYVYT1UQJZzXFknsI93MMoqVso+DFPKq9I0AS5xQZDx1r0w7NBqZtNK5Wd2
         wKiwwZ/ZcfaRk4/nl3OSVhTV7Sk1nLHKExMSHbVrJ3csWwSMuD1XArl2j30bCQYWLEto
         qvZmTI9cRY/1/gsPWRR9jujVoivO6/lIUhGhvrzpc8zR0Wwo9jmRLNg3Dlkn4hItcBeH
         MIvzMLwFfITI8+EU8BEs10F06bN+2waqh4Nz9L94MPwx5/n6hjjBBJOSOdQc2AK8zQRt
         VzSqd8Y9qcst/6HOgAWnDH3m3znUvBGVCl/DvaYgfTL4Tw7hkhD4X7DIQfymKZEExAfi
         BT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=;
        fh=7wllOq/KVvnpBUGVGCddVvPsRucat9Wc/z9D2A9hvOQ=;
        b=jmVQeWqUURJZUkdUBzB6MvZl5NH2Y2UwCe/x18Sor5w27SIwQ2xMR+awKgQ+CW7y71
         anS2ET3sgclW7cCdXpdeb5I2DDwxGLvfHX92lT80W8lXoD4iLJAbjAzPU3MjLZlJAp7o
         +m57QEUhDBXDvpSkxd2k87/yMmWzR/BPb5OkX9dIeR5pkCfrxw9fTD2Ao0pUO2nv4P6k
         BuD1uzpmCY4aeT0CKcKjqRpWc34Q9+CxtrBvY3snJvIrF1mF8b6IWgyeNQvM+tZOuc76
         w2m3HvdDXR3wuKJ+YmpjLBj8r5/hXIxQWWc5dijWyXHUA/ScdgRCiRmGD5V+S5yl+wCc
         Zi2A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793892352; x=1794497152; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=;
        b=RcfT8hHmhsk2UkvLRTpUTxaC8GLle1nWXATWkSQOLHEPJVrBq0mWvlPjiXum/25ymB
         RGzZ1iWWIllaq4/MVm2wqpZvQF7Li3b5wrXaqR+HmaGGBFLczO4mMww9GzZAA54vKOto
         R08C4POqB8xttiVQvFcNXP5VwKiN9gl6mTrinkMm7HgZwKK6bmbtik/kr26xtyqGGf2Y
         1GEL4sS6hySnBg62rWrROLd7PVMAj5B11PL8dJ19B4AD+ZYAUP8N3KLOfHpHE2G3L9cQ
         Dnt+FiDGI5FrgPoHXFq5W2aNWCw9OLBTIpuDoxuW6uzPDny41NywZvjqBN91B+IBKj65
         FThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892352; x=1794497152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjhKddhBYDjam7gmYzCuUV2TommKkjfbcHQoD1zd0pc=;
        b=GwraWTUvFC2Sv/zOETNH96/Dctz/YVe5lIzshYSjil8pwKpem91W4g//p3K+rMzq+e
         A4zSfYaeuOeRFDY2EyZqer5KfmF7MbmoaBfkjxgbiUEXrZ7Z/gmvUgRhBtwOIouZCF5r
         nW7qayQML2omGuroCnt/NradiM8X1WTELhsGAPqr2lP3aVChtUkSS/7MRm7eU4FDa1VK
         trx79C13CdFNLrvcqtzvVBdYYx0AOHQYGQBOroX+Sj/Fl7PShC+yL1PmeQ7UdNuVxV9S
         9RQA0A0Y2joKgL50k8A8K/oRY4Wjivm55g/LdFeS8KWOgsplxP2lDy5Iie9jc2ZxFJeY
         59NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJ/zTLcTSeApRk71isngZ9waho5/Fk2UNNTSoUP2TAdLDGYAwXO6BZV0YnSrJxLoi8sXFYt9k=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9w8BJuu0Y14OdaLMkpB/o5ckDg+5qZquEeEUeComxB2bHl8AxC
	ATDtR14gvmRhRfe9qgUWO5xjiBTswVebDIS75q5u9O+lQF7H2s1bRBwfUrjrv3UQNUMNK0qVI+F
	9CfU/WjiVBKjyyrjkamerpHmwM3zQ1wLZDtFLo5iLV5be47/CRwnO195EBL9VThNGVW2UsUbww4
	XnM7fPfzm1o7yUmWFhRT/qcIvIUIl6Y7lWDUZ91Laxd0jDmHMvk/8SVGyMzQ==
X-Gm-Gg: AYBFou2woe7p3tGHYjRwlMj6v+J35vv4fdx0ZTh0MV3ZBcks1yR3rG2hJ/XUTYmdow3
	QqET3p+hJl52I+yZKIz+VN9qQIfEm7a8v+5VDgkzYY5B/VJA/7M/te3yyZbGVv5hF4gscjY8dBj
	+QRllPur3IMxq2S2FU6NUUvaXvheDMtFevzpLAkeCBnWwk8IhAKTKigHV3lCUitmvyfXu2tKNTj
	1pSb4YKmPFa3rTqO1wFwDGefmhclafkb6mqbeB/
X-Received: by 2002:a05:690e:12cf:b0:677:dc7e:48b2 with SMTP id 956f58d0204a3-67ba4c86589mr11693057d50.2.1793892352264;
        Thu, 05 Nov 2026 07:25:52 -0800 (PST)
X-Received: by 2002:a05:690e:12cf:b0:677:dc7e:48b2 with SMTP id
 956f58d0204a3-67ba4c86589mr11693043d50.2.1793892351655; Thu, 05 Nov 2026
 07:25:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023210238.551855-1-g.osokin@auroraos.dev>
 <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com> <auxy_pv57awSTf2m@sumit-xelite>
In-Reply-To: <auxy_pv57awSTf2m@sumit-xelite>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:25:40 +0100
X-Gm-Features: AclHuK8d8uq9ewtGZRQXy2A5QzI8YGszOw3YIr6_bJKxcDqcRh8qdQM6EdugmVs
Message-ID: <CAGgiveXx8hwsbjvHFHb7qtCOxKDsgOmGN7rCDVj0y_-uNyX4kQ@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: don't warn on an oversized page array in register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aeca001 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8 a=EUspDBNiAAAA:8
 a=t_EgE2yqlgOat-Z1zJ8A:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-ORIG-GUID: eopkXXDEkweidhF4C5MRPjQZcA_IbHEO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX1JrsRlwvOfkO
 R2nyPyeDVjx5XnIjwo+i6EO0tClDBkeIN6PQdmYbh/i70ZLm5MhSs5zMImQ5A3LQRCojE2weHIv
 aWVNLoT5NoKmml9bItZfyYVIh5qHrKU=
X-Proofpoint-GUID: eopkXXDEkweidhF4C5MRPjQZcA_IbHEO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX5gaezDA+PYA5
 zFRar45+maqusCZWflDkgfLXCYCm5Fr+IQy7xFLYHfb9s0H1sXN0SjE0qX+tcLTnsID/n281Wqr
 2vgS9gMmjUiWYMXy8kVIJqPw/AtaOhwxtv3ATQ3f76ejNY1yohGGJbJ+pF/uPyihdBTvFIG1Jf/
 5WDDD5TGEh8YtToJUbXXJLUxFIiU1RMUndO4SoTAuasffRHriC494zoP/Wt61zODcVGJ3ILDMC4
 DTRmNvEwqKTnDppBINgBTHWpjClyvH6L1AiV6SEap6tDQcqKXHuhsHcPx55GoHHW78yhY0PAZF4
 zbn/40KWk4zOP4gvug6iZBgd2KotjFt2ruQL0J5JPyjxAWsrksLLfl3v+wG/wXJWsmSaFtsHlxc
 imeCDI2u88eBqFVbIbPm6Hazt6NPDtc4EuUEnBMsImOW/xBET2qPgWdxXelMhhKop6BUjPXMIhR
 F8ytEcVFFvMfFsBdRgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9BDE045493
X-Spamd-Bar: -----
Message-ID-Hash: 64DTYQ7QJCXKOXEQFINCTW5ESNPHGSKQ
X-Message-ID-Hash: 64DTYQ7QJCXKOXEQFINCTW5ESNPHGSKQ
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Georgiy Osokin <g.osokin@auroraos.dev>, Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/64DTYQ7QJCXKOXEQFINCTW5ESNPHGSKQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 1:13=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Tue, 03 Nov 2026 at 19:34:08 +0100, Jens Wiklander wrote:
> >Hi,
> >
> >On Fri, Oct 23, 2026 at 11:03=E2=80=AFPM Georgiy Osokin <g.osokin@aurora=
os.dev> wrote:
> >>
> >> register_shm_helper() sizes shm->pages from the length passed to
> >> TEE_IOC_SHM_REGISTER and allocates it with kzalloc_objs(). A length ab=
ove
> >> 2 GiB makes the array larger than the page allocator can serve in one
> >> block (MAX_PAGE_ORDER), so it trips its order warning; on a panic_on_w=
arn
> >> kernel that is a panic.
> >>
> >> The size comes from userspace and the request fails with -ENOMEM anywa=
y,
> >> so pass __GFP_NOWARN. kvzalloc_objs() would not help since kvmalloc
> >> warns above INT_MAX as well.
> >>
> >> Fixes: 033ddf12bcf5 ("tee: add register user memory")
> >> Cc: stable@vger.kernel.org
> >> Cc: lvc-project@linuxtesting.org
> >> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> >> ---
> >>  drivers/tee/tee_shm.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> >> index 6742b35..d539988 100644
> >> --- a/drivers/tee/tee_shm.c
> >> +++ b/drivers/tee/tee_shm.c
> >> @@ -438,7 +438,8 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >>                 goto err_free_shm;
> >>         }
> >>
> >> -       shm->pages =3D kzalloc_objs(*shm->pages, num_pages);
> >> +       shm->pages =3D kzalloc_objs(*shm->pages, num_pages,
> >> +                                 GFP_KERNEL | __GFP_NOWARN);
> >>         if (!shm->pages) {
> >>                 ret =3D ERR_PTR(-ENOMEM);
> >>                 goto err_free_shm;
> >>
> >> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> >> --
> >> 2.54.0
> >>
> >
> >Looks good. Sumit, do you agree?
>
> Yeah, feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking this up.

Cheers,
Jens

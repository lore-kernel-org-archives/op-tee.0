Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062B607BCD2
	for <op-tee@archiver.kernel.org>; Tue, 10 Nov 2026 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V1UKZCwp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cUjPLOLG
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1675445490
	for <op-tee@archiver.kernel.org>; Tue, 10 Nov 2026 13:21:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V1UKZCwp;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cUjPLOLG;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CD71C44E16
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Nov 2026 13:21:26 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABA1pn3196031
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Nov 2026 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=; b=V1UKZCwp63kvPwhf
	h41rxT74ANn20jC0bJ7s5PzBJwU6CkrHC6q0sEYzYdGtr5Ek0IVoBAKlsJ4fMLnl
	1xGGn3OWdFrxgSaU+sHBh6jb3kVp94TeHjSqMQzdrJaLl/755YTrKYgWuXldP9pS
	HAQ+IsiMSSdaP9BiWu5osSt7prpr6d787+aQH+GVXx6eCnHrK821xTSxZI+vJlol
	pa0oWwC3KELJhfE69Ax1XTcDcW4+m5kSWESYFXKPY/RzVhnXh+5QCIeae+7W56iA
	2y92KF6Sl8OvEDOehmNz+dBoIdTTlBLb8uaKJJBb4aBMkoULWz2Sa0Ah0bTp0x19
	MDAnXA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv03crwbb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 10 Nov 2026 13:21:26 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b35b88aa94so29430227b3.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 10 Nov 2026 05:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794316886; cv=none;
        d=google.com; s=arc-20260327;
        b=LJmoewRAqnDWXcJ6jQKf6ANMu9q4H4B7oddrPT0FpkbhPrRAnT72hh41AnkHg1vUT5
         dvPH2MjXodMq7ZJItlBYJBrCHQGIoa6WklMng0JgTAq3sAno6kpfPhiRsYWk5ur7hp9p
         yujwZj7nAxD6z4f/+4x7jJgwS+vSLnlkbOr1YjAo7fJw1y1BcGcyMWz1ngDWea8D4Q+r
         cpU14UOL2dgtryGjMbTsOTiOlNvNhJ0bAnO7/TDs3TU2yES3PLp20JxiNhS3Ph9qMs0w
         ZhMKKYGN3WZqR/LbN1S6NrjsH9jKTHSc5baQjJMHiwJUZewjmNijD9OX44kIIal7hGgd
         5rYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=;
        fh=//UCQIVvSSOdixTYH+IjsAEYvaL7qsDgjthbqCp+NkI=;
        b=BIZI58elmXnzIkISIsFeSnJtXT8T1GALJglLDzAzNTMpqKIXAxkQZIkm2xw0IPpfiX
         nCCB2XJlLSTGBHTmcVqZvPn7KAnh6Y90Dzxe5v+E6kX25c6eQWWXcvUAtfCuH2LXS7OK
         O6dWh4bAqfIjpejU5I0xD2qUGdgjB6GcF+7goLQ/28G/5FwQ5wTRh4sFDXiLdXjtKXjw
         7HkHdodohsrGOdWtR0SFH0gdf+CN84ffa2fXnGt6dcXxnwdvG24TR2K1WVjvng3pxw4F
         vie1KMQ9WWQY9ra4+uzcnL3DwoEfd2DGSPrTlmeGC/aYsKybRN4n/CnjGbhGERxD4vkx
         J8bw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794316886; x=1794921686; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=;
        b=cUjPLOLGjNR2sOIAdsF/x9/dYihtoWusuzJe2x4p3X7IFUVWSMG8uwmg1ej+kKCKft
         crt79N22ocxuJ8QN5mrpeyYyKD5uutSzKfEDYXzZrm2mL3UzJlYYnVJHbBLVXsoq5Uso
         Ap/hSb/pWAXiw4NLAqvt+oKy/P2WYo3vHYPPj//caThNWW46Sc4iuIhpqjqpg9qZrU0B
         /DFilAhvQzM0fA4Ys93ioRIoneB/uOIK++VyUQEsmK8PwUXLcyyvCBXY8n8Kq1nf3dBp
         MdUSTQ9HJL+XlRywRH4JpY6250z2ZRfJMm/K2GjkT83SMkbYeDhh9Q/W+5xXA6WE/lfI
         4TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316886; x=1794921686;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIzXasZdl3uuF8A0Q0l5RjhqjxVPq2XhnRyfILIPfK8=;
        b=okeR18pjJQn39vB7hEsemtHXXRB7giyKIjLEtoFS9KjfiOZrIHxC0oOAbJy5O0c/Yk
         aDMWTTopITIo7llwdWYAE0DGO751rGQd5RJOPybTGJpqID6eTjxd3MsVy63b/DqER1Ro
         TuNYNaCaEqsByFYcnnhED7rverPzI8ZZKULpfIh260+Po6jHpLpte/EuSpYBCt+VhgQ6
         1nsSyo5zCKNkBkvFQ9/+vSpuP/8GqgXVcHc+Ez3n9Di/4eswzH6rhnXg04WXX/762IMM
         tYAG7ctykllcGpfZvj/9/n/c3fvVJaoKQXvRZW5TrQvT21B5QEgX0Kl6foQp4Ltb6W+m
         knPw==
X-Forwarded-Encrypted: i=1; AL+hErHFkR5yOqWUSFip3c/bb0roiItfLLLT/Ght1IG7gEZCV7Qi7VSnDlKlwqbmXCg7qXQYM6IE0OM=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9m3Xbut/l9NrtSr4oeidfdrOOuzVaAbKcnAh3uV0L5FJNFY/NG
	i6/041l2i/zPWt5Xat4lhoj1O/YOgGKfg6Jo32FekoRVSh6yTAXhgQaXlNGTpaFGKWWwjSn8bTF
	AA7B3KpT9IgXmNP5meTKSkzAydmDtDLvSGzbO/oLEVdsywQO79R1C2ttSR8WyAS2Jki4TCmrZS5
	3g/+2WLdr2sfkP9/sbCMedIKRTPN4/8pHTv4s87mawdrLKT+k=
X-Gm-Gg: AYBFou00moM5MFlnr8qHhqMVVSuOgYvAocEOrYGW+wHvoZen532gDqz+UTie94MUtNA
	hDi942wzJ1l8FZaWIOhzZlnJ1Q6YVzmjCMJmOuF+LvTd5rch4GdmNy9lDfol5GgMvCorEFsetWC
	0eLTbW56iemYwvMKxI/BLY9KBbU63onBMTU5jf0FSn2hmCBaxxqT5+cht8g/+zwExi6y8FG6dZE
	nn9uM49QxRcryNaav6UjGfQgKUlgXHxyXT1GTAh
X-Received: by 2002:a05:690c:f04:b0:8b3:615b:71d5 with SMTP id 00721157ae682-8b392be3ceemr13387587b3.107.1794316885510;
        Tue, 10 Nov 2026 05:21:25 -0800 (PST)
X-Received: by 2002:a05:690c:f04:b0:8b3:615b:71d5 with SMTP id
 00721157ae682-8b392be3ceemr13387437b3.107.1794316885060; Tue, 10 Nov 2026
 05:21:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026150345.284404-1-g.osokin@auroraos.dev>
In-Reply-To: <20261026150345.284404-1-g.osokin@auroraos.dev>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 14:21:14 +0100
X-Gm-Features: AclHuK_f3vyqMLgyBVux__eXfDzVIlzPHxEDHotsqfEZeO9lB7Q4GjX6bk6lk-o
Message-ID: <CAGgiveUr_1OX3qvq=kH9sdVggtgK8LyiSF5KDtCfGwqdxkRXew@mail.gmail.com>
Subject: Re: [PATCH v2] tee: shm: don't warn on oversized request in tee_dyn_shm_alloc_helper()
To: Georgiy Osokin <g.osokin@auroraos.dev>, Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 25Tl91PgCKDI-NBH9xy446uwudLfTOrr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfX+4PeGr43T1JL
 T9Mkw90Eju6eTnAO9BfBRfXbi29xQXU1WEoav8+ZlugTGgyMVKaotn0sIAVi9pKK9hQsmZqRTds
 mtuWtewvw0IhRhqGTMmHua7KZZcCTJY=
X-Authority-Analysis: v=2.4 cv=FuiQbGrq c=1 sm=1 tr=0 ts=6af31a56 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8
 a=Uqf-NjlQ7lL-qC9IIjUA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-GUID: 25Tl91PgCKDI-NBH9xy446uwudLfTOrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MyBTYWx0ZWRfX8eRyS+zJUYVa
 csvhfqLWZsFJ22PuXnhYN0UdG/Tv4UAeGsh4pmLwvXV5KTBq99/6UvPnqSXEHgG6Ihw6yE79Obl
 KhJzevUQlHttJUAITBIt+rLVkgd35/RUpLkD/HcCFRfpM+BoRsLygTwl6oWibnyCFL9CS5TyKfY
 c1PaApVREWUXURljip+Pjpl5dIzJ5w2+2sINxqPYT4hEt/WJc2oLsg3DftnldinGRS4LUzLcCSr
 b+RkuRGRAByVRdnoZJ1p8ppFLXCl8OVp2APmapiu8U4cjYX2wY4BOT+3E9V6J/d9IRDZOpJAskG
 6pSQd90hh4PeVxfboHNjbwa27Zh310QccgdqVoqqorp72dP/kvW633LjO45krIe/Fq2+9p5BhDK
 8hNki4wiwCQ2g6PWgGu9E0xXt2GLtrcSmJA7ksbmF+XhMUrOrMMWTtx913VDKLE0lLSC8IzAW53
 A02wVbGUStsvNrxttXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CD71C44E16
X-Spamd-Bar: -------
Message-ID-Hash: ERCHLGLOAUPJ5UXBFXWWVIVQ45YWIHGF
X-Message-ID-Hash: ERCHLGLOAUPJ5UXBFXWWVIVQ45YWIHGF
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ERCHLGLOAUPJ5UXBFXWWVIVQ45YWIHGF/>
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

On Mon, Oct 26, 2026 at 4:04=E2=80=AFPM Georgiy Osokin <g.osokin@auroraos.d=
ev> wrote:
>
> tee_dyn_shm_alloc_helper() passes the size from TEE_IOC_SHM_ALLOC to
> alloc_pages_exact(), which needs one physically contiguous block. A size
> above 4 MiB (MAX_PAGE_ORDER with 4 KiB pages) is more than the page
> allocator can serve, so it trips its order warning; on a panic_on_warn
> kernel that is a panic.
>
> The size comes from userspace and the request fails with -ENOMEM anyway,
> so pass __GFP_NOWARN.
>
> Fixes: abd135ba215c ("tee: optee: add optee-specific shared pool implemen=
tation")
> Cc: stable@vger.kernel.org
> Cc: lvc-project@linuxtesting.org
> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> ---
> v2: Fixes now points to abd135ba215c, the commit that introduced the
>     unchecked allocation; cf4441503e20 only moved the code.
> v1: https://lore.kernel.org/all/20261026105209.161195-1-g.osokin@auroraos=
.dev/
>
>  drivers/tee/tee_shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daa4af1..8b117d6 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -352,7 +352,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, siz=
e_t size, size_t align,
>          * and there's no need for any larger alignment.
>          */
>         shm->kaddr =3D alloc_pages_exact(nr_pages * PAGE_SIZE,
> -                                      GFP_KERNEL | __GFP_ZERO);
> +                                      GFP_KERNEL | __GFP_ZERO | __GFP_NO=
WARN);
>         if (!shm->kaddr)
>                 return -ENOMEM;
>
> --
> 2.54.0
>

I missed this one, confusing it with the other "don't warn" patch.
Looks good. Sumit, do you agree?

Cheers,
Jens

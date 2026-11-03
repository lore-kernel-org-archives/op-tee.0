Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED84606A328
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzHT2IwS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q9nQGKdv
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7364041BD6
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 18:34:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WzHT2IwS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q9nQGKdv;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9B1B641BD6
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Nov 2026 18:34:21 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HffPa326304
	for <op-tee@lists.trustedfirmware.org>; Tue, 3 Nov 2026 18:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=; b=WzHT2IwSgehWqDBq
	Vhz4Z5HT67p975+82qgbF5lx8OMrgUUckAAC48pzuFP6cikOxUP75dOGOMhUXWAc
	IU/ReqlodDXuPIJ42m9zDtRAVrx+4AuqiCjtVGd3mk6/lw/omR8BDRc10f+bvBhU
	A0DO++soEbUHhFft2IJVQQgudalGQJ1FE1goSxAryWq+gnrqcZoobipGe0sE/l/8
	0lOaiCimWHv3jjS/lGi86j+ih2wWBzA4EfHnNZpe5+oDdbwF3KvvE+n65bfDclnC
	8OMZxKtfbNAuXV0ERkHs6IzEASzbdZ1yKPwxy2n/lpQr38PhZYjSTrSPPgzcYrP9
	WH1cTA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pg9se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 18:34:20 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67532014b2fso7118163d50.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 10:34:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793730859; cv=none;
        d=google.com; s=arc-20260327;
        b=rJfcq5IBIihD/HhgzXXIs8qRu1Ff04xNZLc9V3P6U0ouPg7pjgkMRUDfATaLz87wOy
         3KSSmGwxzCBFlYxMXyxPSzH5PWKvphRPKMkmxvSVhgmguoLLjKDWCdIbQnZ9YokvO6HV
         EHuiAdXXroSz7yZwiWIAiIshM1B0x4E8cYUPJ5FCYPDRrlkOMeY4IvmNTk7qh5+wGN8Z
         U3OM03JtlsPOift51KeZfIxcoC5G9BUYxqlxwOq2ZBtXHKMOyy6JWU4yCh8EMuyhjPO0
         7QDYXcwfGgVagrU8FkHawFBIKbmAoFzFfk6urxYnmChFu/V9VfoZ+TZ0SRj7DlL1Bmg3
         FHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=;
        fh=mU0P3r7WtqBXy3db6t0uwGIlMjo74lTNGAmoVqtG+r8=;
        b=fzwj+VlS9fC5lWNkP/Nzu7s8GySHEe1Ww5Alr2pXIPTidI7scKhWhllnovzuPBcFDF
         76iwkCOHs5TleYeUPZHWAwXFJzGQkrdCEs+jXhlzd8gTzvAJz4OMoiT0XDVnNQ8iLjsq
         irfl2rVfdXd10jy2zanayJIHFEZAHEWHjhVyhHsW+rDkt4vz4LGBUQ/cvNTVRk65YEEl
         OV8/aUqPCZcPuaiimHgpyQf5o8hpZGcxLXGP+DLiQhjlHIBszIPhZZqw64YErlDLSWKA
         yQEOVNYWHFPjYp4KWI4pnCmzq9lhCMxxJ9l71jO7YzskLAE5InnWF2YWC2VOc8NC1RET
         eiNA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793730859; x=1794335659; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=;
        b=Q9nQGKdvjJVSwRI5m9RIuUCkTjy/jfLu9KtggDVRmxbWy4V8dZmL32wG6oKKRU37gL
         HOalxhTxhIfAfprzw4/Jz0GLYW3x9BtG8bcizeV7LtaA/NWz6vS2DF34GYZN47in1iOw
         07OXKJhoz7n0/lwQUVxZpFNOcbisydyLB+hXsM9BblAe00EH2h2Z6TbDTEGmXPDCViAj
         N+Y6pNvSE9ZY5SwwesTUSSvr0bekZNPUvNtYhrzRkpGcIP3S1A69FpkNHfXF4b9CRDFi
         te6neu9oWOrznYXSZ08KaGRP0qaiMMZ5txViEo2+ClOGkD1gFtjBUx/8uswzZU//48md
         Oz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730859; x=1794335659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/GFDLlgK5HAoW68o12U8J+27i2IlZDakQ4ajhKBmDhE=;
        b=e+lXU9KJrsaS6X9O2LMFWu5xsp928rC89JsBM3Oz+4xbH4pLZnhte1yaUWWitAVnIi
         gb7b0hLdg0dpPMSRy3n5M6sgYsMadc7d4DKHuxrIsbkjHe+FmqwvdDXp5MYtLmBwESDG
         mvTVU75KyrSylt64VJqz1WLjidU3IuL11Akr5+tBbKQL6u+ra7wzoJSEK61XgDt3NJyO
         V0rbleC4jlo2qdWe7GlLhRHRZ7/Ug2zunN7PHrXw5KGG/K9KJX9h+AQn6MsquMxVjruh
         77bbBurDYV8f4gjpI5TbRDqrhBZRY8UMuqZpnb3tv+KE5Z29d4TBrW2ZgyRe+FppAYol
         Nxiw==
X-Forwarded-Encrypted: i=1; AKwUvByhJbZ38Ok3Yspw0ZPt0DFN49yO/E7D3eUesUxK5muLDzBOtV99/VtrJVX9qBzaFAvOqCu55AE=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9P+O0WW1ha86N8b2qgNf/WHQaB5s3qCUdRIMYhWScBxc7cemOm
	m5GKh6sB/tinhYGXtyL+4aiYhvYiadjZ27U+ExzjWqczg72Sxsct34aj8JCLGn0Wnw/kyGvscqx
	KX+eTX+bWDVIS1m5MVnBqmi91usWvDVgrRmXEt8aLlpFo+QDom8udmh1+nxusRB71sXz3rCib+R
	3qae0rTBHoAYTpIcPQOjMB5xDuClckfC2ctAgxfh22PXAJO0k=
X-Gm-Gg: AYBFou2KexU54Mf2u+kfJJSIGofFdpe9TSzCzjvqVIVv5tYFwavQdrgN4FRMbiI4Boj
	xcvUqoJovM16GvhbW5qT3+lRgKrPmKM1+wRrtnAH3tFuRnIzHNy/7N90Z1SdHEre1rvSsS0mcA/
	PLIY89Vo3YXBQGYJlSFTaviZ4M/rrV4Lv2nX4N0pqkW3P7p7K6gH0M4DJQcGJqeHCzHRLgkYIir
	6LdWj0sw91PJh39iiHat7/HgoF90vHT+o9/UD5H
X-Received: by 2002:a05:690e:4088:b0:67b:bb72:dd09 with SMTP id 956f58d0204a3-67bbb72e7a7mr7242610d50.44.1793730859387;
        Tue, 03 Nov 2026 10:34:19 -0800 (PST)
X-Received: by 2002:a05:690e:4088:b0:67b:bb72:dd09 with SMTP id
 956f58d0204a3-67bbb72e7a7mr7242592d50.44.1793730858912; Tue, 03 Nov 2026
 10:34:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023210238.551855-1-g.osokin@auroraos.dev>
In-Reply-To: <20261023210238.551855-1-g.osokin@auroraos.dev>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 19:34:08 +0100
X-Gm-Features: AclHuK_m9Jis2nJnxj8Yo9gCVbFV_e32G26TRERoPo0wBnnCXCaoIJVZvpoofSI
Message-ID: <CAGgiveXkWxrdeRYCxBC9X0eQSUAAxF5N+ioe3iM6GZ=pSqHHeg@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: don't warn on an oversized page array in register_shm_helper()
To: Georgiy Osokin <g.osokin@auroraos.dev>, Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX8AmReiMccWhh
 zoqx4XH+qTqqMXLTNeTGx0uF9zglecGAsvQAbETgPuWrcjzGFCDssQU3MwM2cn3M6a5Q/bJsm85
 QO0PzZUWUgpaiFTAwcFMBi370Yo4zmnF806/sT6p3bwoj/ApiSbl2hE3uK/avlo+14JM2NYui0h
 PpvYQRhLEjhWvJLoJSPNGUIv914+l4y6htVwwi/sFDLbRaxrwK7ntNH8WHOO9za4ZDDlwrV6GAz
 3CVUFYcJQxDmX3E5xk4zDv1oZEgDJxlCCOt370L6fbX+9f0w+WATm+Szpxr5YT2YmCUf4Yyk8gm
 eEH2knE7BB9HyPYvzZrvfic+gQ5Mt7DFRz3n/ldJawllu5mO5idn/TA/nihyVGP81AXXtDhMQZH
 /SQ8Pyjzuvc7Nw7VWCokkDgLhnd13E48HsNxEtlwlLjQQght1DM9Rbjk3S/kXK4eWoEz23Hr/V1
 cGfqw93LuUCDkoiJCpg==
X-Proofpoint-GUID: OwAs9PA-JvIGimgq3M5FyaNXdUFZH5Hb
X-Proofpoint-ORIG-GUID: OwAs9PA-JvIGimgq3M5FyaNXdUFZH5Hb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MyBTYWx0ZWRfX79MY2juSTHDA
 zOiLfIbgWV3YF8JIJkzhQUMoCDL5Dv57vWTjZJm3Wa34rqYdU9Iav+gtkH/Mcu5hBl87BKYDATt
 7KH+BPkB3R7Hgdu0d2ZoeEirN/pDpzA=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aea292c cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8
 a=c0YJ09nfCN-JFu4Q_T8A:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9B1B641BD6
X-Spamd-Bar: -------
Message-ID-Hash: XTCEG6TVIF7FRM3BXRL625CQRVZFSYRT
X-Message-ID-Hash: XTCEG6TVIF7FRM3BXRL625CQRVZFSYRT
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XTCEG6TVIF7FRM3BXRL625CQRVZFSYRT/>
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

Hi,

On Fri, Oct 23, 2026 at 11:03=E2=80=AFPM Georgiy Osokin <g.osokin@auroraos.=
dev> wrote:
>
> register_shm_helper() sizes shm->pages from the length passed to
> TEE_IOC_SHM_REGISTER and allocates it with kzalloc_objs(). A length above
> 2 GiB makes the array larger than the page allocator can serve in one
> block (MAX_PAGE_ORDER), so it trips its order warning; on a panic_on_warn
> kernel that is a panic.
>
> The size comes from userspace and the request fails with -ENOMEM anyway,
> so pass __GFP_NOWARN. kvzalloc_objs() would not help since kvmalloc
> warns above INT_MAX as well.
>
> Fixes: 033ddf12bcf5 ("tee: add register user memory")
> Cc: stable@vger.kernel.org
> Cc: lvc-project@linuxtesting.org
> Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> ---
>  drivers/tee/tee_shm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 6742b35..d539988 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -438,7 +438,8 @@ register_shm_helper(struct tee_context *ctx, struct i=
ov_iter *iter, u32 flags,
>                 goto err_free_shm;
>         }
>
> -       shm->pages =3D kzalloc_objs(*shm->pages, num_pages);
> +       shm->pages =3D kzalloc_objs(*shm->pages, num_pages,
> +                                 GFP_KERNEL | __GFP_NOWARN);
>         if (!shm->pages) {
>                 ret =3D ERR_PTR(-ENOMEM);
>                 goto err_free_shm;
>
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> --
> 2.54.0
>

Looks good. Sumit, do you agree?

Cheers,
Jens

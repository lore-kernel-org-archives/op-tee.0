Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E650606A326
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MwSX8dwV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rex2KszM
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 833B345467
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 18:11:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MwSX8dwV;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rex2KszM;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2C96541BD6
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Nov 2026 18:11:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HP8X64091184
	for <op-tee@lists.trustedfirmware.org>; Tue, 3 Nov 2026 18:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fMhmvsxHHHQOUhG1Or6hR6Sjkr7Y65FQpCjxc49anXg=; b=MwSX8dwVtuIwiv9C
	K8JmKwZ8fyXsHU8k7bBrs0Vnr6bycUs6FtP4KY3/u3BK4iDUPa8zqwhIgj0oGfyC
	dRDce0LxASjFqINShLUbdjsGl5O1SuayvO2TA6jgAfxr3O4zc5WY6tgr8SvvIr/q
	YZwSRXjxxyEhkqWcvRdi0U28BiC8P+9H4eOTOdf2uYVqhGJdNY4NpTnJtTgtkZk8
	73o8l+yOvzEx5BD0/XF4Q9HbQ4ybrLy6ZJF8OX6+fPg1omtq9JRjTJc61IpUmgLH
	S1uwJUaTWi6XWjbTm9lmegy3a8JkFBh/37Iitp5F4iiuXPBeSa/fQkA4ru1oFpM+
	xUrLjA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqkgp8e0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 18:11:18 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-677d10671b7so6513854d50.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 10:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793729478; cv=none;
        d=google.com; s=arc-20260327;
        b=R4CDzPOqMPdf6VUdMm2my8nsEIov7xgvKrxBFxf5Aq6zxo4VMNBrNCZynWxE0F8dpO
         0HtTovyv939gr5LR5bBBLVVZOeb61EwKuGszh7RILfUzReKZHGRkGIQInn+4Z3SWXH3R
         USGdvLqmC3nobr1exA8kyynh0hzQx9C2Vjm60nlMN6PqMLrO8UvVG0/AYfyA2WUyb6uN
         Tqax1rkSTuzb6XUM2rZIxsxjqmgWGeT7Z5BQAYXrUWqV17m09AHPEUWND8hr8vA1iHns
         MGSkaUV0V3ddMTo9wsrrA2AUjDFrfTPAoK4yxOYlVlieHezdPC9unrRYg/ArXWrLp2kd
         loGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fMhmvsxHHHQOUhG1Or6hR6Sjkr7Y65FQpCjxc49anXg=;
        fh=xoc+3WJD0FOejwsaw9ttTgNv9hEosnlfVnaKhnx6mE4=;
        b=QB2gjULY3qlskMrW96kYSWshWC0TH5IaaSS+0T+MtGhQFM4tUdbMp2qWd28hgX1aYx
         jSIXgK/TZgmr0OQGFcPqbiTF7M1y2kvawVDsDA6wsWEMuAAoPRd7b0sIYfken0fh/kY/
         dJlgGrg/hRPTKWax3rO/93dwJdk3nj82fAKug6Do3ysv5HdOzlSGcNOwmzHf34nwa9MI
         jVMJ1LrHPNE3CF/nTCb0zPAYTFnqYKxYt7ZB7KDtSZu5DUHKO8su4F8wbgojzpanQcih
         0j9H0X8d4Xy8R/7rq3Qch/Z2ZUGrXoCTreCPgeRPGfm8m4t0f0Cdv3GNY2YBbgutvoFc
         5MZg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793729478; x=1794334278; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fMhmvsxHHHQOUhG1Or6hR6Sjkr7Y65FQpCjxc49anXg=;
        b=Rex2KszMsNAgXLPRCGrlhuc5zTUn3ocQAuAU1qT4mzrUT0yFGbv3QgcP3+V1yBYCV/
         M9+6tVHYNFWcymGfdWNnUDUpngu8BvXj3qQQgmv15w50s4fCfZ6rG+dZLggxNFPBvp+Y
         nenivZw6/LUgU02Ig0/7QsAQVilDDXdomYCqdUwdi0T0ZnVVCgjaxmdsSvTNRNu5s+VD
         dF+lzWdleiIBCxPCOMovkidj5LPii97z/cRiDAsuRCdmuYOGW1y2Nj8s3MtaBJ8SD3Jv
         x0/up6I4LtjBT0NbUNGIoRmafxHeL2zZghvwLKqjJ0eN1Ja6Sha7yVLYzSegbomXSM/a
         6A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729478; x=1794334278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fMhmvsxHHHQOUhG1Or6hR6Sjkr7Y65FQpCjxc49anXg=;
        b=OR1zi4wkIpgBtFd+yn7MPeiGeyogF+r+xhmuU5gPIGg3Z8FaqwmayqH5+ollxc4CiZ
         FnU1RO4UUcGm/BM4YSa7+CuGxoactsJZ9R12+02oRdTgjCGV1DRWq8B/mfi26W6mLalw
         HWa3zsZTo7rrGx7Q7V3shtWiKzQxNR56BXZK9fyzq5+nFrM+5hQUknoDsF6vXWpajlsY
         mYjo55V0lN/x16uVLvL5UaDklL09+b2DUHg8tNRKf6UNV+pOH0BXDM1hjChp8X3pg6Nu
         V3f8r/MMChGtvEbfsMrnBIcDD15KqM4MPxkDGJARhbuxIFNQz23maTWaCPQiszIpR5c2
         5B0g==
X-Forwarded-Encrypted: i=1; AKwUvBwYCahSz6ym2M93PlEtp2EEKsvakCWwUfKBXtZolcqQcko7J6TZNHyjr0io+eMNEzxGWkP2278=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9bMQXszcIWJmpnWZk/ajz6vSR5MW506dThPjn3apd2YDOW53Id
	yX2byOZFD+knviOVnryfCM1/mvebZq4WEjbv/Wym8ymBLWLQE9GJtMrbYhJNa/8DL+krMH2Moui
	6ElPHHeMUdLqoECuwe9gFIF6I9iyG286W0eIOtxKgap+CvzstJ1CwTKkMDEP8tmUi09jcrOi4XG
	behas8y+jIX0gpaVHopg2KKLUx/JjKOfcWAF1ZmW7UbekH1NQ=
X-Gm-Gg: AYBFou3rlAcizuxAQh1EXzM3Hh4ihr1KB9vOb+YUVloCvPId5q3NA/1XZGbK9dn2OXH
	P5U9BCs8XQxG+TLSPYa51o9msHpmC2jE97HmmFELzqenOAVbX1ZuWAUN9fe5qxyOGf4nfrXv31O
	jNwsZyv24zwo93EV3aD5zD+/vI+rhQPbJqiVSuBQk7WqRfTQAa4BAeX0R+RVjJL8jhapIn2lDmR
	NjCoIY+ilp7294+w+yV6YkIMpuNslSOS8phM1p+
X-Received: by 2002:a05:690e:4506:20b0:677:ac49:ebc4 with SMTP id 956f58d0204a3-67ba4fd503fmr6927849d50.67.1793729478134;
        Tue, 03 Nov 2026 10:11:18 -0800 (PST)
X-Received: by 2002:a05:690e:4506:20b0:677:ac49:ebc4 with SMTP id
 956f58d0204a3-67ba4fd503fmr6927824d50.67.1793729477588; Tue, 03 Nov 2026
 10:11:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260831105824.3141687-1-shukai.ni@kuleuven.be> <20260831105824.3141687-2-shukai.ni@kuleuven.be>
In-Reply-To: <20260831105824.3141687-2-shukai.ni@kuleuven.be>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 19:11:06 +0100
X-Gm-Features: AclHuK-dq-0izxpI304_Aq_uCDrGKVYvoCCr3Fr1HKUn_3aoN5LPt7oBOlvyrrk
Message-ID: <CAGgiveUQ9_uZLL=KgGtV0PNiBRbHhRVMqKxWwE3jww2asW98VA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: fix page count in register_shm_helper() error path
To: Shukai Ni <shukai.ni@kuleuven.be>, Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MiBTYWx0ZWRfX5isp7811DZl2
 10r+nbeskCAGXQWTLN7HwX4/9uvkExIBqwf12XQZxdKORQZ43UbTeOBB+P1nJCczEVN8WQVXLk1
 wjG6nPQnp8qNVaxhfQzmMz/XZig3038HzdRtUOfosi17tfFhH5OS4BA+6RaNcw7uzGOJ5U+UhUk
 odXSPQcn6DCta+33IlBfbTOUbU0C7K3nemPd6ZgS8xEF9qazB9oMvqGPG4ysQWJAEEuc3Bd/oQX
 wxYD6VpibQ97NqflwXdgDhSueoItGRK+YSCsGfjJWkWPHqCnc1pYXyibi5P5qaOg9l9/4V6g4+q
 oPzMSuryH9nm+2XucNLlFAQ8Yqf7fMg2/DDcXAy+ZO9B6Htw7WtC/mURGFhEoiK2ItdQIWJKkO/
 IdYJ45dhCEXhC881G25b1gkdlaszP2DB1XvJTokOKM1M7YEOk7ocMpmmlR4geCxBWVhaPmDBC4K
 JwKJfuMfuP/1D3PVkfA==
X-Proofpoint-GUID: XB8_otUBZlLSfm5BrjLfK2T8YlRRiOuN
X-Authority-Analysis: v=2.4 cv=Yoya1IYX c=1 sm=1 tr=0 ts=6aea23c6 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=bm2aaB7hBGvuia8LsG8A:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MiBTYWx0ZWRfX3vW+nkZ2dzHo
 Z+PjYA9dk2JFxLvzO4MVwLScZYqxxEoKvvPcu01i0T0QckxjYzdOakJY1z/r4e1c5ngt3isz/UZ
 iPOcJlIlCwD28xF+nP0DgsV1XvwQ4kY=
X-Proofpoint-ORIG-GUID: XB8_otUBZlLSfm5BrjLfK2T8YlRRiOuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030072
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
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2C96541BD6
X-Spamd-Bar: -------
Message-ID-Hash: XP5P324WPFFIEGXMHBX365TMOE565KSK
X-Message-ID-Hash: XP5P324WPFFIEGXMHBX365TMOE565KSK
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XP5P324WPFFIEGXMHBX365TMOE565KSK/>
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

On Mon, Aug 31, 2026 at 12:58=E2=80=AFPM Shukai Ni <shukai.ni@kuleuven.be> =
wrote:
>
> iov_iter_extract_pages() returns the number of bytes extracted and sets o=
ff
> to the offset into the first page. For the iterator, the number of pages
> pinned is therefore DIV_ROUND_UP(len + off, PAGE_SIZE).
>
> The partial-extraction error path instead records len / PAGE_SIZE. For an
> unaligned buffer this can undercount by one, causing unpin_user_pages() t=
o
> leave a page pinned.
>
> Fixes: d5cf5b37064b ("tee: fix register_shm_helper()")
> Cc: stable@vger.kernel.org
> Co-developed-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> Signed-off-by: Shukai Ni <shukai.ni@kuleuven.be>
> ---
>  drivers/tee/tee_shm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 6742b35..fa446e4 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -454,7 +454,7 @@ register_shm_helper(struct tee_context *ctx, struct i=
ov_iter *iter, u32 flags,
>                  * If we only got a few pages, update to release the
>                  * correct amount below.
>                  */
> -               shm->num_pages =3D len / PAGE_SIZE;
> +               shm->num_pages =3D DIV_ROUND_UP(len + off, PAGE_SIZE);
>                 ret =3D ERR_PTR(-ENOMEM);
>                 goto err_put_shm_pages;
>         }
> --
> 2.55.0
>

Looks good. Sumit, do you agree?

Cheers,
Jens

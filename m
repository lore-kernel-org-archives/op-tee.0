Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44081CA5FDD
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 13:20:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3EB65453F0
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 13:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790947205;
	bh=rtc4I2W0neXfjG2Mk3+xO4PZrj0tXMXOGRF6QZh7oNg=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KMxR0fgSL5fGu53dOlxk8BXrOEQXdwUUjFK4sGechF43w5MFOgqeB+KR/hisOIBOL
	 vPRK9CwV2Hp95haMrP92dNXb39AxYmY1qKNfOPiRIuEJaGGWAN2bTf0zImuBsgn5n/
	 GlvYQCimIEo0VJvATGiWhP+SiR7XSs/6KAHiw04NrVLprYuRsUgb4I9s9eiNN521xG
	 Yy1/tbXiwlPQ8RgjX28cK433snPwAGsd01AVsk1lBPg++x3Aggh7kTiyZJSINmSpH2
	 G560WyEn7CLmEOUI0Kevqb/7b0HGXVItdiFylvR/qJD/OZOY4y1SM9xfVX/qntpDMQ
	 NIGBDfUzsgang==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 068BA43864
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 13:19:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jjyUTBzA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LC95S03j;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692D9ub61606205
	for <op-tee@lists.trustedfirmware.org>; Fri, 2 Oct 2026 13:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cEpMA0JjPRqWoUbHxm2V96T8iNrtnkKOUULUqASLDZU=; b=jjyUTBzA0r3m1Qlc
	srXGtd3iPqrX+IX4qpNDVKBmQTMR/PoEO/Y8otwzMyBe04Szkq5X3KmHc0En0jin
	F6TiRKGZVUnYBU/d2dQJro7VCzz7sfCbifEsBbYbv9c5Fk/XrAVE8icvSAAzWQ1m
	e/ZFyucCLlB5z/PIan9IJtWCaX0+etL7Hqfu80GCAYtU4/RzTQ9rjJSf+rQbd9d+
	IyZlcuiYZ70K3590jH3huD/WQYsY0xyDzKnqKv2BuLDCRe3wJLAnAcIgpeI11RvC
	KrWK8pjgJA+tJWRHuiEnkW01Rvq6argbhXHnog/GxdtSS1wgU/lUPZo4MLbM9Hp6
	3TBZXw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tk5h1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 13:19:56 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-88322409239so113302727b3.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 06:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790947196; cv=none;
        d=google.com; s=arc-20260327;
        b=JazIiX6UQ28qOlB6Wh3Htm/6TIpputti3rs1DiDt5KscVqlddoPYTjfZUSZ+UMATV4
         ADBeE+s06aBYGD+OrVISjR09dDNGvQuNvM8MZF6/aA02Ha85AfQGsbEYyCPDIVGTz/mY
         EJ3V2N8Q+/I0abhk/Vz15Zt4ATIFjNoHZcGqdEfSs+A90Pcpp2qN9aE/QaTtgdOwTCSA
         NKvu1A/vjrl+TJDcZJhm57o+1aXyM//DKgQ42FT7J+s2AKFzz7t+IO0VawP9CTWyyDa+
         bQOsm8SkdKcNklayIXlwzGNasaIYnNLJZSPYkwS3aGaFuuDFK8yo8nZi0+8baMMqJfo+
         rHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cEpMA0JjPRqWoUbHxm2V96T8iNrtnkKOUULUqASLDZU=;
        fh=DMq5nVsijliw5PziBVlKGjsitOkCe2FSoBweEQS0qbc=;
        b=I2R3+jknA942VUTom/qvfJPMpA4thKCj9JbfL/DaJrgkZo8f1zVHkOiWWXaWVt9XRc
         Re3cdGHmHqsCciF9hP9+/OvU31yT20hJ0b753ljdDK0FGvj0pcLPT7eO9MgTHp1VqyFy
         FvCCnwHfsuZJ4gsLd0PQNLDk60P0yDgFOErv6v2NT83bnGSYFS1j2XGawxYN4TLYZdNc
         PfEXUiBnxargFiXRHz6qh0feken6kNBlgQp1YfZIQn5ua0F4DhhKmf9JGmOezD6QsXZ0
         hMwXiN7KABZg2dhH+AER9dwI2RQFLFXtbe3vlFFxaPXx5ztpXMgd9qStRru3rg+fSDyQ
         9UVA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790947196; x=1791551996; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEpMA0JjPRqWoUbHxm2V96T8iNrtnkKOUULUqASLDZU=;
        b=LC95S03jIziDGcat03F5oGg24UWnz/RZeyyiNoowEZtneINH9AnJZAmog5wf7zsAX/
         c5dpgJ73CcOg1UmakayXtZPPbpd4WMvurfRShO3Glm/WzO7m0F6WMJALecWk2qIRWrdf
         NcPP94xNXFfW1ijxPZxdJdqv5uMJp8GrfBxFqdO7K1bDFQ+c9XEEjiVZshI0CM2hV8Wu
         GmdRzCYgIGFfqPCcWlnqC/9QPx7R5Wz2UjVuJWZWiFstsiDx8bj1sFiFKtd6JfdZ0O9t
         iVymiXapzblSJ9KBzx7/4H8/JTh+qHZgy2jVi+2/7uxlEhfqqMfoI4jbsuARNyMxIM/x
         +1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790947196; x=1791551996;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEpMA0JjPRqWoUbHxm2V96T8iNrtnkKOUULUqASLDZU=;
        b=mnWe35zgECRVchbhxL+xAKs/vbieA9kDDqAQ2d1ukchcBIirxDmMwwyENnagmG+wpk
         8OQvhZYHvJAyMd7LKJxFbOTbhS3zzmcPYZe111j+n23h7zMJg5+G7/Pmr8O/+0Jj/8hp
         yNkzTGI5CUpluhzbzXX78NjXYXzcIUE5sHE2z/65bueUsLsVqo305KNbXrAC7c0HS0bk
         IesBovaFCggxHxqtMcVa+DJjrRAVHiSk1K2gmmX7refESj+RS91OMNUn52hdpiDAyyBp
         5csN5W+q2uOF8FnxAI+Qq5LjxEzLPTSsFfQUfOGUqNK93Zl1Dc+ubyljI5Np56k2QI2d
         QXJA==
X-Forwarded-Encrypted: i=1; AKwUvBxC7KI8xsu1IYcexlWu9/2a9kuQbS43wpByBtyHSzsHOU4YkQC9iF/FQzQU6YA1/pPZpj/fiOU=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJdEpR3q7Bjobjq6q/PzjnZ+UyA52Gyi/ZdUfMkUNUjXD2vy+FG
	FUz6eSQNNiZqgPAUKyuuvXJY4N7cW5dPwOrBAFQInZ9oDdInciqpyuTOWXpkT+NrKjkGf6EQ3AV
	blnQLsx5rv6ckTLFgTz2pDfiGkEULMqe2PCOj81dvAjB1wM/6hbJIZdBcyv9bPCkf+JcKAW3Dba
	mrWHgbDegvdy1K/Xlnfcg9Te6qKJrXyFDPPSm4xnT1WY0+jHg=
X-Gm-Gg: AYBFou05M4kdtvoqulmnwkhJDXpd5tRZkVPhgkwMGu8+ksT/FfUaBtadPmhLBblHcRJ
	LMllBUTgYdBYDs7AFk2xhIMp0QkIl/yFx+A96WXpzRlSFNJc2lAba0SEQo3n3OySNZ1y4WeU4Gm
	JUKXuq08cSiYMyTNDSynfB0gYg3W4/fAxHj+QFoKY/BltSGSXTMHxbTxk=
X-Received: by 2002:a05:690c:4f09:b0:8ab:33d2:1553 with SMTP id 00721157ae682-8ae399a5c2cmr10779527b3.19.1790947195528;
        Fri, 02 Oct 2026 06:19:55 -0700 (PDT)
X-Received: by 2002:a05:690c:4f09:b0:8ab:33d2:1553 with SMTP id
 00721157ae682-8ae399a5c2cmr10779407b3.19.1790947195103; Fri, 02 Oct 2026
 06:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260904134732.1072541-1-mahantesh@nvidia.com>
 <20260910161124.1561170-1-mahantesh@nvidia.com> <arEiHFtNB3p6g4WB@sumit-xelite>
In-Reply-To: <arEiHFtNB3p6g4WB@sumit-xelite>
Date: Fri, 2 Oct 2026 15:19:42 +0200
X-Gm-Features: AclHuK9Bb_57qi8tNaYFfNTw_y4EmDWk1JbzV8LgwHbPeh2rOth0Y00qCx1oMO0
Message-ID: <CAGgiveWF4oGhvtuGYyYeoN2jw3xUCGrZsGKpT7sC7yN_x2Oeng@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: ffa: support shared memory offsets on
 large-page kernels
To: Mahantesh Salimath <mahantesh@nvidia.com>,
        Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: EfBbsu7Z4VmroTmbhpqa-Ui2AzePuRvv
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abfaf7c cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8
 a=_bwLWqMKaEQuuFKEIS4A:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MyBTYWx0ZWRfXy+eQacexUhCP
 YWASaUgHOD+uhyRfDTOLMxCJOmNbhPsJPiSokPoezGAHSlLCNgrQBqNjbiuE5tJesmY7kpjtvNF
 KaUNG2q6dr3BPItJwsGZ8MsYh52l7aJnWb4RBuQD8gaxkBmugW8OEVgmkhQQPCKuEexiOcegJr2
 Uc60MzOI8shJYhDNWPZvIrX5TXA+sVe4noyZQr6XY6CoAJJ1oZtjx8lKJaCykoP00S3FnJbRF/n
 +J0k95kTMc61rbKi9iONcXDzELkAv+ZZzfEG/N/rwmGas+vdhZE00RRHqXufNiOfbfhkDyrxZgC
 Weg3D7GqFFsyOCq6sU+RdPku3EeDjjtn6bMsXkjh9wPp+lH1uiYnlx1H0G1m9OmmyvhA1hSkpoi
 7kAse3SZ0YtsEGe9KmFb6JxLCfyeAlDzDlmCfsauYJqVWjEHPPK9IP2p6sV0z9fpiOUHLwcliEV
 of5wSon0SP0wo3Gc0ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MyBTYWx0ZWRfX1xlRVlNQ0Hca
 NZJLlpUMvdP3ViFr5veth6tirVyZ2labq9r4VN0jfQBwrBnkRdeq380e/EtbARYV4oq2hgeEYUr
 88/2GMgKSXclvJnJqDb6qG2pmYZ+3ec=
X-Proofpoint-ORIG-GUID: EfBbsu7Z4VmroTmbhpqa-Ui2AzePuRvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.199:received];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 068BA43864
X-Spamd-Bar: -------
Message-ID-Hash: DEAZI6APNH5VGPKN2TKDWNAIU5RCBRT2
X-Message-ID-Hash: DEAZI6APNH5VGPKN2TKDWNAIU5RCBRT2
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DEAZI6APNH5VGPKN2TKDWNAIU5RCBRT2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 2:25=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, 10 Sep 2026 at 16:11:24 +0000, Mahantesh Salimath wrote:
> >OP-TEE FF-A memory objects use 4 KiB pages, while the kernel page
> >size may be larger. Consequently, tee_shm->offset can be greater than
> >or equal to FFA_PAGE_SIZE, but OP-TEE rejects such a value in
> >internal_offs.
> >
> >Do not encode the excess page offset in offs_low/offs_high. Those
> >fields describe the logical memref offset and are copied back into
> >tee_param->shm_offs on return. Folding the page offset into them breaks
> >parameter round trips when a memref is reused. They are also ignored by
> >the OPTEE_RPC_CMD_SHM_ALLOC response path, which uses only global_id and
> >internal_offs to construct the shared-memory mobj.
> >
> >Instead, start the FF-A descriptor at the 4 KiB page containing the
> >shared buffer, the same approach as optee_fill_pages_list() in the SMC
> >ABI. Store the remaining in-page offset in internal_offs and preserve
> >shm_offs in offs_low/offs_high. This keeps internal_offs within the
> >FF-A page size, maps RPC allocations at the correct address, and
> >preserves normal memref offsets across repeated invocations.
> >
> >Tested on ARMv8-A with 64 KiB PAGE_SIZE. OP-TEE OS ran as a secure
> >partition under Hafnium (SPMC) over FF-A. Verified registered shared
> >memory with tee_shm->offset >=3D 4 KiB, memref reuse on the same
> >TEEC_Operation, and RPC OPTEE_RPC_CMD_SHM_ALLOC (xtest regression
> >6007-6009). optee_hello_world, optee_aes, and xtest regression 1005,
> >1007, 1008, 4001-4003 and 6001-6003 also passed.
> >
> >Fixes: 4615e5a34b95 ("optee: add FF-A support")
> >Acked-by: Liming Sun <limings@nvidia.com>
> >Acked-by: James Hurley <jahurley@nvidia.com>
> >Acked-by: Dave Thompson <davthompson@nvidia.com>
> >Signed-off-by: Mahantesh Salimath <mahantesh@nvidia.com>
> >---
> >v2:
> >- Drop helper indirection; mask internal_offs inline (Sumit Garg)
> >- Keep a single ffa_offs local in optee_ffa_shm_register()
> >
> >Link: https://lore.kernel.org/lkml/20260904134732.1072541-1-mahantesh@nv=
idia.com/
> >
> > drivers/tee/optee/ffa_abi.c   | 22 ++++++++++++++++++----
> > drivers/tee/optee/optee_msg.h |  4 ++--
> > 2 files changed, 20 insertions(+), 6 deletions(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking this up.

Thanks,
Jens

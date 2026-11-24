Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED1D606A31E
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gULAaHek;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kUIsEgS0
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 18C8345503
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 08:52:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gULAaHek;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kUIsEgS0;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4279A4549E
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 08:52:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO8Jrkm3225364
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 08:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=; b=gULAaHekKgIQsjv9
	G4FUbn8KOs70p9fRP3Z6T3j25V1tkmBhH8gLkOgJTNlifcpeNyppzllUTUDMOb3Y
	c0hCImuX/3jtOcOHliQTtYe966wxKG2VP7QA4bLNwn+5YHeWJskWeZi5GYxCbmLt
	IO1QQX/QN0E2Kf+okUJkOMZIBcjbBYUJc8N+s3uqSILvm87w3yAh7jWzNiPCx90v
	8VODdoptdGiLMKqaNK2zpMVWCZtBD6A40L5/ki1tqXYXWDnZoucvF4ILB6VUACUY
	qh43wOs0rzVfBEli7xv4ywaeJXGhfsrPK1WfMvtATAMk1GdZNY+xHn/+rzydye0v
	j68nEg==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4x8f2329-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 08:52:12 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67c0efb7b97so2179125d50.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 00:52:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795510332; cv=none;
        d=google.com; s=arc-20260327;
        b=S+HVmCy+nbS4/uU/akkISgDeaLAz/gJiHKoRAj/skIZQ4l9C4cHTLLnN3FqNec8qK5
         Q9ruggVU7tQLMFIZTmPqBK1EqrSumsktBwqWz4ZwJLDeQVJVNamyXsg8T4+rm5r069K+
         Kx3KqkPNmrIMh0euMDn0bInfBkyyII0QldC0HlTuw3PHDsWTspnug6GOGQIIwKYGmDo6
         RFfm36WfeMbyoHKFIZR9G0Wi4+M9L7WGenOiKyUFlawbOY7CA8DRje6WHBbuMDhLdpZy
         h2+3sjQZsJdeICaQwBthm3IEFwfKb4rxQldfpe3+N6tyvoJrGS2RKFIeZ1+kkh2l41hb
         tcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=;
        fh=Vbi1R0/RLPu3CtVOM1lIxgQXaK1/v4b4jdAsNCW5cyo=;
        b=jBbcYVeEApexbUz08Pmq3NZZihNJCHtD1QomwYrAhbyxgnRlf8yTvIUeNPv9/HM4QV
         kiilRpGSsdH/TZpMT9rML/mGloVfYXXAd9CEwy1W41ttbnw/WiRUDb8/q8Wg8T/iHuDA
         P/wqcaat/VG0tTcN7+tL71oTDgReiLW1qOIR8oL7S7j/htntHvYcOJa645JX6vUqvjq6
         f7x4ukxoIuDkVB55O40iwTbb/+Nb7V5nWK+WTp7VP+aDDvn2XOhYUZNLHEbjLDnI2V6g
         lkExJCEo5hYwVT42Eq6PAC/HpL4JJMiiCxMwVlmV9FDh81FjjNZfbREt4lyFDOBYzJsf
         ASqA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795510332; x=1796115132; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=;
        b=kUIsEgS0pdgSYiEdjtBgAybIb0TbNhuGOh5wUBxh7yLnGzzAQSPoaTdy+fyluiS35B
         ZLsQgy1cW4F7b2ZhfuNkEdvzlIQIWshSDEaNY1n8hZDvjm3D2nj6+1jv/ryO0QJBE2Ru
         KvJ+6/vnb4pZMigNYQS1pNizKQr9OHuv+vH0Cxx1eezZYH3ln9/Ajo1dAS3cnzepdgZl
         CGBgEJpPVPrX3uPnce6HPEVF0TgsvMhvBmnct0MKkNl4XG86Q/e3AB+Vb8NX2IYJEh3M
         pYTJT9B3mNicbYuDfNWhpXk3+WLhFFd/aD8KiHLodbyE35JFk1NJ8YU/HCP9XFPXWgkP
         wqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510332; x=1796115132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IL7ykB//MICeY8UkBsqKUeetbddAABEUJHUTtFHkJSc=;
        b=nfwgpyIiCYggp6pHjadK4OQXdkeG3V2Pe9jsnUr954uFRz4JlHv7E15AKTbFQP9iNp
         MRDigo1FW9sGI2Ku9pi60FFXfEWikFiHlLbkXG+NbRs2pIRyNvswCxE9mdajfAKuNfT4
         npTp0pd40vsMTYgewEG7uvSlVCclHEaqF//m1qEG3V+Qo+KhedMdfm4FKtxha9E8xEM8
         8wmVyk8epdlmSVrhjdiKqhiTMhTWkR9AgWEpnd4KXiVAdI91RuJKRIIKEBB3PyagPMqQ
         TZGgo7otax0NfPg7j0I/Oktpt+e3Et36GTRWbddssJKgwupBBppIEMExczLFWYtgl8Bt
         0oaA==
X-Forwarded-Encrypted: i=1; AL+hErFs5zMA4jNRJBhXqvjly1Xf42x060SpTUnL0pnEn3BKiwubmwInf0bUQtfNsGgnflQR8TaPuQM=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8sfR5tEwf+zV5SoMXUCq8tHOpIAhl3nqJFP2DqzvRZafjLpQGO
	lUxzZTzAFtOLlJau+Jqo1usyvk4v3Mds+4F3aXS4Wcpd/J7Y7djG6jiDNhLpxKzgcRQ6QESBDjx
	bqvMCmSPjnJjQAxBdu09NpdKXgeS3kR3T5ddkkXYNdjB20OcUEtEwZTwIdcMUgL+6tSox4PqNGF
	I49YDfnUrEl093TGpUxJxW/RK1bf1c7Un5u1viWUAChGCGtEw=
X-Gm-Gg: AZFdTZfar5OVpwlFlDianor9AySOqhVwgW3jHC22kMo4SooWkf7l1Uvpg2Y6bm6jVL/
	2imow3eBJUCtpKMtfSVRxc4JUaom5UAzcFN+cwsZ+v61ew9j8qhO3J9m9iYKV9DVuGBu15B8O/5
	uyLzG5uNI5GICstym8/ehGOWzDa/z/ufM4b+O015FfUYQvpUHOCc22s3uQjaP71D10JxG0eepVa
	CFsJn6c1GkGvwQJlEk56XA7RESc6J2Y4s+s2jVl
X-Received: by 2002:a05:690e:450c:10b0:67d:eb6d:7458 with SMTP id 956f58d0204a3-67df44555damr2919002d50.55.1795510331875;
        Tue, 24 Nov 2026 00:52:11 -0800 (PST)
X-Received: by 2002:a05:690e:450c:10b0:67d:eb6d:7458 with SMTP id
 956f58d0204a3-67df44555damr2918995d50.55.1795510331414; Tue, 24 Nov 2026
 00:52:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
In-Reply-To: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 09:52:00 +0100
X-Gm-Features: Aa3M54rFHqUJNXQjemvxf-Zt82SGX1HKER8XMMPmIBzLcusnrFpbxg6otAaKEJw
Message-ID: <CAGgiveWm-xH_SjA5QrBJx6NtQhWyQWMw2FvfSd9SfG-wghpwmw@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: sync DMA memory for the device before it is lent
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX3gICn552ID7T
 Q1Ihr88t5YHezNW4o8fZneIe7GXgjKDGiQudo8+WekVblD8YTsbH3QO5i64LxQeuMMC9DGbUmZc
 sXZE2y/xN0NgpCibHtNSHU29waIxeus=
X-Authority-Analysis: v=2.4 cv=JbgpPkKV c=1 sm=1 tr=0 ts=6b05503c cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=6jbKIeu7AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=EUspDBNiAAAA:8 a=i7LB113YSaF0UBaY600A:9 a=QEXdDO2ut3YA:10
 a=uujmmnXaIg8lM0-o0HFK:22 a=-0VUF4iAjVmhXKmeMUOz:22
X-Proofpoint-GUID: _DWDvsOHyniYSQ5vP4edMfmHf_wLSCn7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNCBTYWx0ZWRfX58J1XRAmij0k
 B0N+Ps/i7Yr6h25Yni3hykJ3RD3RL8cHw9QqblaYb1eo6F2N7jf4gkGu3IfqK5JRAJbMggTgxCN
 4aHGahvZXu85M8Gt8N3p4jPSgzYwdq+OYrWWhD2/D9MQ8Sp7Za5QhfeKR0x4dhaFnY8JbUDSXDU
 y7tN90F9rsIgaXHWC15K0dJIH9EAVipiIYvfjddsssBWLaGBbAjE/Ia+6FQ7toRHxQJqRIJ/PAD
 QkFEARBKRXfSbDiL8+I3vpe9DNiiCKjESYfOPihgwXDKQW83h/7EAdMhvDKZvSW+n5QBPzQP44v
 tFNzc2SWOxdx3hCoJf26sJwvJRZh6LKfSSXbN4SrRDbQ1sdychNDMSKV8fYlaYN//NRQqWzdG9k
 9KRDVZ15RKhGxohwC+XvQC/AmKwUEa9fUIWXQ8QU0GlKZMqRr12vQpFMAVVZodL2WmbnH4yVXwC
 LLk4ksNcbSLjAw6HH6w==
X-Proofpoint-ORIG-GUID: _DWDvsOHyniYSQ5vP4edMfmHf_wLSCn7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240034
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.224.72:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4279A4549E
X-Spamd-Bar: -------
Message-ID-Hash: EAT76QFA7DZ6UI4IKNOSRC2D6PH5UGK2
X-Message-ID-Hash: EAT76QFA7DZ6UI4IKNOSRC2D6PH5UGK2
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EAT76QFA7DZ6UI4IKNOSRC2D6PH5UGK2/>
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

On Fri, Nov 13, 2026 at 2:22=E2=80=AFPM Tyler Baker
<tyler.baker@oss.qualcomm.com> wrote:
>
> tee_shm_alloc_dma_mem() returns dma_alloc_pages() memory without the
> dma_sync_single_for_device() that the DMA API requires before a device
> uses it. dma_alloc_pages() zeroes the pages through the cacheable
> linear map, so the zeroes can still be dirty in the cache when the
> optee protected memory pool lends the pages and a Secure Data Path TA
> writes them through its secure mapping. A later eviction of those
> lines overwrites the TA's data.
>
> On an Eliza EVK with OP-TEE as the FF-A SPMC, a TA decrypts into a
> protected buffer, a read of all RAM through /proc/kcore evicts the
> lines, and the TA's digest of the buffer no longer matches:
>
>   frame 0: 0e534d8c..., reference d98ddba1...
>
> Sync the allocation for the device before returning it.
>
> Fixes: ab09dd6d9201 ("tee: add tee_shm_alloc_dma_mem()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> ---
> Vincent's direct-map series [1] cleans the range in
> dma_zap_direct_map() before the lend, which also covers this when it
> can unmap. It returns -ENODEV without any cache maintenance when there
> is no lendable pool and the direct map cannot change (arm64 with
> rodata=3Dnoalias or rodata=3Doff), and it is not a stable candidate.
>
> On a dma-coherent TEE device the sync does nothing. teedev->dev is not
> configured from firmware, so it is not coherent today.
>
> Without the fix the TA's data is lost:
>   https://lava.infra.foundries.io/scheduler/job/554467#L2262
> With it, the data is intact after the scan and 50 lend rounds:
>   https://lava.infra.foundries.io/scheduler/job/563840#L1979
>   https://lava.infra.foundries.io/scheduler/job/563840#L2008
>
> [1] https://lore.kernel.org/all/20261111110738.872947-1-vdonnefort@google=
.com/
> ---
>  drivers/tee/tee_shm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 5c47a36916c45..70a273a425f88 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -297,6 +297,9 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_cont=
ext *ctx,
>         if (!page)
>                 goto err_put_teedev;
>
> +       dma_sync_single_for_device(&teedev->dev, dma_addr,
> +                                  page_count * PAGE_SIZE, DMA_BIDIRECTIO=
NAL);
> +
>         dma_mem =3D kzalloc_obj(*dma_mem);
>         if (!dma_mem)
>                 goto err_free_pages;
>
> ---

Looks good. Sumit, do you agree?

Cheers,
Jens

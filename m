Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AE9606D809
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NPpr+yhG
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EDE3845502
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 09:15:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NPpr+yhG;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 25A6C451BA
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Nov 2026 09:14:46 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A969vUc2668040
	for <op-tee@lists.trustedfirmware.org>; Mon, 9 Nov 2026 09:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=CVfpLeBo3svBArcIsMoE8xRGgAiB5mlup0YLE+WU
	miqzZlFGvtGNDDsox8E4acOXK3gFfIwXz4N9NuUoFgsvQYzB36fLfpJjeTRHqc6s
	uy0gSyaVcClNbyTOzA2q8KZ6eX3yeJTqJ/ms2Qw2AhTUM6hxMMbK1fitbXikNI1A
	3N1EEpVY6+IW/Gl778ykaY1gR/3PEmrnDIUD2fTp/fa3Hmb8ffAS6UIbg308OCav
	3+Nx4dhrSnt3yHskSXih/XRxBQbXscbe0NIynFJkTP78h6opo1QkdQ+HiyPEGFcV
	CwIq9i7JbhtLjvjXIsVC9XTOcHDqrOSl9f6bgU8BbCtJVA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsw99ncq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 09 Nov 2026 09:14:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f37c94ceeso134963585a.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 09 Nov 2026 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794215684; x=1794820484; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=NPpr+yhG/YYdy+ZwavsVBMFd+1ApRIOK57Qe6on+XMqkZ4C3PaUJbEVM862nyNWLTa
         E7iFX4qN+992r5+yMJ7IelTZndBX/SWO0S6SaN9LAuOXeAyOOQY3OqzWHmp6vnj5X6PI
         YA4pt//WdfpwHuGXzXD+BNBU3MWtasRWPCpGgwBWg8DkILAl6hqIwBevAvD0Ke2T9GIc
         cgYUJ5UtlYBqSi0rNErpPzEM7EsQ9+4aYzH52hOnvXBSiqc5gK96sfFinKfWZJx0WdLl
         74Q64STNTfpYBzgLuZWlbPmK2o/mDuijsGaI+frnABfZt6igCAmfKKbVg1U7yiPZg7vH
         YUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215684; x=1794820484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=qKIJ7G49Iq8/aJsNDD2JAghiUVRWd+hXx2s1qkEOsCI3dS2TtlBLCP8Ma7dlACRA34
         zj9CxhqyBI4AvrU7T7oRGj6Fz3ogFoDRFpiN2xtgXwhF8B+9fSw0OF03oLFISSkKk1Mp
         IsSdwv99fDEpCH4/INezWGGmEmaggL2MBTMqFf2ugmHaEePd4vii1unPlBoyXYOcem2H
         MKAgsD8FSm2gt5hpaAY3hbaN3TLgsmBFCttkPDcen3IGI9IFB9NakoEJbqOQod0k3G86
         aYETf0Uqx69TKqW9CtJK+B10tXjnXH59T53ENAg2s2BKVEhZX749b62T+b82PtdvfVdm
         UNrg==
X-Forwarded-Encrypted: i=1; AL+hErGPc2FabfFsG2CWVEhm7n31G+zVkCewNgr94FEAllg3F1gUWKoZfoFFcDFbmWEd9dYRh28vQ2w=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9LzBA4zGkoFYJob4EErIE/JVWgDZVUfvDJ0wyDIjwpr5ERInY/
	FuRlSJGdRZpjq52MBi9SC1MRLW5s11VwZ1KHFxlsXpee7ZMXRBPUHv3y7h/Tg2DoHQWd2X9YpDX
	8YISRVmLDD/VjO5bBa6MRWV+20X2qmBICAr2nTqgCHT/v4PUykM03kw5ArdBK5KgGN0aI5IuU
X-Gm-Gg: AYBFou2NQWpem+Nr/nkxZW2QWAwOzx4gj6DX7Z2UBY5CZFrk1Zko8Ix4VATQXkKkBld
	2GGpyeuaJIUgQLkN+5jVI1TaKLt9bhM3nZaeHcKJSfes1Zl46GSm6A9s6E+UN+6Xni0vhNwjiik
	QSMpez6L3S87lNKypeCq3oIu4jCOJRYdBa1ZwW2eBrFtQX2ruRvmjkJ7Vx31KSzhlSq2NZuJq3x
	YE9uc1FF0QA29qob9eAWhDM2GRQ2LxHQKCognv9EgOlYLElbjllU+FYZmXGI9NJOq8pqGfyioaR
	kslXhdufLEPQ/tywM7FroUc8s5nhti7YACqrJw+GdvXV8aJA/mku6CrB+OqwmqBjoQeaD/Q5VFw
	kshuQV3wiN8vhpcyZn3X/ImsL1kHZF4O6+csQXRRrn6YDufejBsaLdYDHbQtx9a8=
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886324485a.13.1794215683439;
        Mon, 09 Nov 2026 01:14:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886320985a.13.1794215682798;
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm161196965e9.4.2026.11.09.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Date: Mon, 9 Nov 2026 11:14:38 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <tr3hhmd6gqvvzrngazyovx7jfbw6k45yjw2mipqu3aegsy5oda@7qromidf5btb>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Proofpoint-ORIG-GUID: IDT9WNdrHd6ssrb_tvoqORQxqdicbmzu
X-Proofpoint-GUID: IDT9WNdrHd6ssrb_tvoqORQxqdicbmzu
X-Authority-Analysis: v=2.4 cv=CMq/zhrD c=1 sm=1 tr=0 ts=6af18f04 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX07QKYMe1SeEM
 n2xRFFfeVRBC3bBAfAyClWiPH3B/IEylX5ZWdixai1wCsIV6C807fzkl3UC36XV1zdMIeluX1jw
 yiWb2BZpUGnTXtwx0H7CV+KoqzUqu4c7BW2ZxR8rsBGAZc/ApIjQfVYr9saMnqdZp0xIzcYqSw5
 MAB9HdjmgyFTZt/yyU6BcJUqM58tGWwAIIHutAq3aNtWj9/NmQC7ezIjm2hUm51Fp90Kp3zp6Dj
 PgxfvZXne9k5FUpf1LGtR4KrcVMZmMJI5xxGw+PkRFQmTZYeJqSdGpN3F0cKLEFJEu8hwSidKd4
 RHEJ8ZnpK1cowOsQSAdyOcvG7TcJpP+q8GzGXoJHqyb3xGOxaCIY8GngCXcwrW2ItQuV/jsV2yG
 a3IIgBrwYYMYadgvm4+9qW6Of9F9DZB2GUJQBzQuFxih3/VdJrNoZ9kL3mA8L7s2VPWoIxNcEsS
 0SX1Xd8LdmhyU3oB5mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX1duwkJ9tzOOR
 moOhoHQfAr9wJoufozadZyW00oJYmt8eVNPF2vESJCNyF7qfRnldPdYfKuiW0f+HloqJ0heu3U+
 ZdMUuVJeoCVAo6FJAK9BpiopqizbkTY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090036
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.43 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.33)[90.31%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[61];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.199:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 25A6C451BA
X-Spamd-Bar: --
Message-ID-Hash: X7PY4KCPP6XW74NEWZ2PZKWON7NYIBEP
X-Message-ID-Hash: X7PY4KCPP6XW74NEWZ2PZKWON7NYIBEP
X-MailFrom: abel.vesa@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail
 .com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyper
 v@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X7PY4KCPP6XW74NEWZ2PZKWON7NYIBEP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

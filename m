Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FC1606A31E
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kiBMDhxA
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 28218454E0
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 06:08:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kiBMDhxA;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2C0FA4501F
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 06:08:37 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k2C83701106
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 06:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=Mu+lZvdLXuWGpOkRTkHFjM/i3/zxBEn62CaGxwiM
	4QAwVoT9XEi4yAVQyTS/Hdf4oK6g4Bc9UAYdPk+DRdycbrtCTJCG8mMPRAhd8Itr
	YJhqFMUPxIvAUoO28f/gr9kwh8uoUQMFVNIJ4mHntvWYoUNjLLZJkNIL9C5NO8j5
	4wzwAtnHxt9pAGjuHvdm/dL4ZGq7SYRNZIslZ6b/jAPWSWpvoexho/kIjWyCe8Go
	XEM9WzZZfx7YDi8VBJiRGkruQKiQYtAWiuR5g/M2YJX70BEeqYi1vnUAfiYQx25H
	1Q6Q3rvSf1diwPrHavfw3ko6BktLi1o93wWElVUR6hp2Ww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky0ywb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 06:08:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so1039065585a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 22:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795500515; x=1796105315; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=kiBMDhxAl4hbYKyh09yO6kDKauyRiFu2MFJAYpe2w34/IKa8Mn1htkkuEdrKLi/WU+
         3dB3SWJ5zrK+Vrz2++l4Tzjah7uSD+iC9LSpUFHyDv2axop2qTwkSjsi0+RXKb4WepJ4
         nsY1jbCCYQz6AaY9qLoEZLoXbC6ofD/e6/Dq5kCDqIMpqVucLJjn0wBjjYkooyMaS3LH
         DldZeiVJN+lURoHluwZFNYo3POl1+iMuU7hsgSGg6wuUOcsi0VlOfBF7Un0lfE8duxFc
         SP2Fbh27lsT5NeuWQcwqyfnhgNBG16EL5+xQXtDzE4lI4iOUgn+n19jZZ91Ffkv1chxc
         POcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500515; x=1796105315;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=UPjdSRqH3a0h7DZOxw47B9JsbX91TpcGqQKtR5MxrN46HnZtY4Z6hSECUQ1qhXOAVp
         7QRAiujF6t1Y2t0prmgpgB17JhGMvNWudTuVC5K/jlag4E7Rfmgp8+HjanlTzQv3n63h
         IcB/HBol0EGHIRWTIWqfFje5XKnZUjuYPL/djbZk4UUkqGFicfLA9mNALX6zKCLZXzDZ
         4Uguw/3g1dVuWLF7Rng5OEYuVNsiTLR5t8XqeVxTVDJkM3VQXw1d6LAVhEk2ejKjOtnx
         sGWBFP/66XhR4Lbe5EV652Ku19+a28UjDHLhCD7HloCsV0CYCACskW9NTN4wYq+BfktP
         S50Q==
X-Forwarded-Encrypted: i=1; AL+hErGzNgNENLO/Zfc8t6k2R2nIXgJIb5Av6xKX/gSrz313gJbgUpk5Rf+H4hQfHL8I4ntc1VbZhKk=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9bP1/QuFw9NKnKPfNAbRuiUrfVHFiaV3Zp+dsaI3/PVO9/dHES
	lXdO+XZWG6RHdB2BGPsUyimzGyX5wRsJKWXSs2zbz1uOzmhekNsmjNNNfr7RBZzXu23KR01te5g
	RIG/2iwUeG98avhFgJKrEHmvqPhe+fG3cbIsnPMzd4FupxCt4NvJafJ97/aIrAevnT0543do1
X-Gm-Gg: AZFdTZcP825URfizgDOMcdSmG4m36Npa0cGzyQkdcXTk4CuCuYqKmq+wUISVdIarqZ+
	gcRyEd09Ul3ZADg+L7TE0OCJg80E7BSFeBtE9cYiNd+ZHT3jtmw1FAnd9W9ugc1ouLybIoqtJ/M
	gsyYTsqga/59yFdkAJCoNtxCWo31k3qhrW/Eh2LPnLIf6MfkVl3gUI7Nygx/t5WZ+ZSborqcqu2
	xAfb022D2341qcV3ZvEYkDso06CRe0qmVLSU7jfyBVqt/g4nD/N5rMzmFqoZQj4cYYCLBjFsr/L
	lr/89DS5KNDcPfOSDa5UvA1LcOT5Cf2b6zrh7KqUBu7nUYBGatE4zTOZz7XaAdEjXSG1wNeVV1Q
	qVBvSzj9w2LeSqxPD0KPfo7Wbp2NxY7EvV7FNimBAmEwq98emBpjssLHuZi8GF+Y=
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433052985a.0.1795500514550;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433050285a.0.1795500514001;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm23005124f8f.17.2026.11.23.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:08:33 -0800 (PST)
Date: Tue, 24 Nov 2026 08:08:29 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <7zkdydihgjnqxerwzbebrcryry37hcqc47dpzqmoxdgc7qt3i6@uanst4lmvvkn>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b0529e3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gAKQ8jAfYlUw5fbHAs_aZctW3Y9Wk4_u
X-Proofpoint-ORIG-GUID: gAKQ8jAfYlUw5fbHAs_aZctW3Y9Wk4_u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX4spaT5ukIRzS
 HqDtwEl61Sc0tkjU08LiC1HnT55+t8rKyrMbUmgotrzI0xWfBue+6ypsK0rphfvqeQftbECUlEW
 FiIPwWLn8RFHTk4GqetS3tzNu7b4TMk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX+qwFWfvcQkTd
 yK8quDg4nKbJkeXRJSfQuosJZEkdyW91duCOovBnOttiX2pyD082vHwpSzmrBPW6eMtpCa5tMa4
 p2TbGg0iElN81k/jBWBOdDsH4T75o//rKppvYDf3z/Hw69gt2Cpng32WRmUMBZkBJz4WmlcWaI1
 5vmSWbIzAj18fyhUOd7esym0h2ZjxPJj+pNHBIUdwyxWfxBfhCHO6GpxIhsZaXv8csOGg2VMI2A
 fLBAU/4W41i5huSlX2I6Z9MSH5Br/mb1586ep3K6aIu/yR3h9HfaBp1pXv/gM5GIbKlYiBizVeT
 aDuhj1tXKl70crREp0ePBcxASeSRy7+LwgMyHdQuRRcE8e6kjXmCa3AeK3NG0LvPijTKW94ZWv0
 sC2XvRsET62/R2mH6D4hvWjvi/luBOL2HWRHHInOKoHNIRW+NrMrGBp2g+VlVJYPAKLuYAmx6WY
 TspwlkRcCWyVIW0FEAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240024
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.22 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-1.12)[88.41%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.222.200:received,188.27.161.77:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[61];
	TAGGED_RCPT(0.00)[netdev];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2C0FA4501F
X-Spamd-Bar: --
Message-ID-Hash: AM4PFUT6GID6HOGBA7RFGUUFHD4TRWOO
X-Message-ID-Hash: AM4PFUT6GID6HOGBA7RFGUUFHD4TRWOO
X-MailFrom: abel.vesa@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail
 .com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyper
 v@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AM4PFUT6GID6HOGBA7RFGUUFHD4TRWOO/>
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

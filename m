Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522E606A31C
	for <op-tee@archiver.kernel.org>; Thu, 26 Nov 2026 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RY50G9hW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EBl1TWxo
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CC73F5035B
	for <op-tee@archiver.kernel.org>; Thu, 26 Nov 2026 10:51:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RY50G9hW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EBl1TWxo;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BDE1544ED3
	for <op-tee@lists.trustedfirmware.org>; Thu, 26 Nov 2026 10:51:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQAXNF31147811
	for <op-tee@lists.trustedfirmware.org>; Thu, 26 Nov 2026 10:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=200pD1qxcbYrH+rY85P6dSaf7A2jkzmfoaqS5iGSEdc=; b=RY
	50G9hWjIj2WbHap1uW1oNf+BZ/tjsTc4Qwvnyn9Kk4ZTTKCuduCUGsn/4IBtwvdJ
	QdMG0H8E+7c3UUNbZcy0RTegvnTCb+yy2g/l8dq86sRGFlx8gcyyyHdUkwRdsDWC
	N1G/VTRT9nISTKyWJC0LJ0x0WtCwS7G86snvmyew8wx7zyZHwtebLGMe4uz5Mu7w
	QzRYlpLBKwX/jQDudx9Y7D/U7a29ZVTlYevJ9ylnjIgLQlV5KU5oQPYrnyyPEMlZ
	vDE+gVIESpHkH0DONfB9IR9nuplART2DK4947fFpwwq3JR/dEu1PQ5SVjf6OFzcC
	Lbt9dlGZ1SnDJqi8y09Q==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6fw7rwvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 26 Nov 2026 10:51:36 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b4fc2d32caso93343147b3.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 26 Nov 2026 02:51:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795690295; cv=none;
        d=google.com; s=arc-20260327;
        b=a7K8wMYhOMW5O9/NrniscFrffZN18asMpYUJXwXBDFQbPj/6Z3JqAiPZoZk4z+kcZj
         LeXcKdzH5ze3UFw+ZznaOAFQzI4i/59EqmwsiDYc4NUFOFfu9s62zlY1rxx8LQGGwXnF
         yKC/weUZWZxxD1BPhUtkE2Twg3l+fJmy0DP3+KBWNB2cH8BHwDuw6lqeJIY5Rk5eSuEc
         ozSnDUSk1gfGB5M5/kXGcXa8QEoEW6F20E2k9PUR/nR6R7SjQaR4e1gOSiXT4JEkrchL
         0j+GYlaabnaj2rs1r23pfqWpvyhw0awcC3gdA0rsa/v2G8e7fQf8qsS+rHNCfL+vLg3X
         BW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=200pD1qxcbYrH+rY85P6dSaf7A2jkzmfoaqS5iGSEdc=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=hJGaq1zVV8HabZKxQB24TgZ7+ER72B9DShiCmPPwGp4494M6qUKByHtXNCLOMNhwmn
         fcB7snvsX1JhzyZpToo5TphZynMsghR6J0JX+YrUId13DO+RupXBlriJETInPFPmydOM
         sQaejrDGXeRoolWCAYnC9UnyUREfW1JjHi2bgNtFScHpMG3P/19LmOYv7XUvdHsBwYOg
         ph7MhCP+I3k6ZNi0WPWnb1XOxz//0Zn1a2quP+TtHk+7dMbEZ9LGD4Kvdpp0Yl02GETm
         xAChc6snr/CAn7SJpFxzm9cBCBzrGq9Wu6Pu49Zjl1S2FsQAThOYjuBuCzjPmedKurt0
         KkSQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795690295; x=1796295095; darn=lists.trustedfirmware.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=200pD1qxcbYrH+rY85P6dSaf7A2jkzmfoaqS5iGSEdc=;
        b=EBl1TWxoSSxj6CcC+f7W5f3bkDnXpGxKy8v8loNd8PGn+zPaoj9CKiaemp1FR4n35F
         IUgqvFoD7kPgPO5gmzMiXR5PKq0IPXkWw30+e7b3M1SvhC5FMqWGB9rnE8sP/CLh6iq6
         gNlnD6tuHezffterF175A+XxtYKOKp6KvmxYxq4JkDa+BoVE21Jv7IbFZ1dpCsGjL3yM
         clR9qm87POaB22MCx2FApEgMCQF4r9cLUhiALEC2Li1smFGLTvRUeVp7EFdeRuo5x27Q
         Qtuoh0aykLtenI7zQZd7Yh3X1+/cdzg+40nkqsSspmWfSXoOYtjCqzM5HafNLIASyNTp
         7M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690295; x=1796295095;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=200pD1qxcbYrH+rY85P6dSaf7A2jkzmfoaqS5iGSEdc=;
        b=N3ze0tT/bn/UraV8Nm9hYr4JeM2fPBZEq1qpdG0o2eYf7IBZDJzy0KbnKKpqRfk+75
         Y2UV45hdFMKGkZ+oBERpViVfjFNiLQhum6o8E6NWN/Y5PnX53bjTpQziSxzJBGo8mwl7
         h9e44NJyn+9nkjNuctkgnqlI97hB4rs8FEUrfEYdw7OUIUFt8fqDdJa0gwLFLexzuXQs
         r0m6vOBiTmn76dTonRGsCBOSnzIK78/DAH3UOargNzUt+KON0VF35H2zqP7F/qMzrnr5
         1+aicd/8Ye4u7fs4PhzCfQbyaxWRJrkp7FUVyrK1Ch/RGX+0l0No9rgEpBnSRjKXrRqT
         0UCg==
X-Gm-Message-State: APuU4Z8T0LZ1C7KiOHL8XoQrMN8DRIY9SMh9WYtbxN//T59tBLg6pxHK
	kPT1s2S1Pcrac3SSYHEW9qf8/FfK8uQyYULSg/O4U4tboc6cI+A7zpPIiTm1A5koA6M9I3KrsT+
	Na3H+eHYDybgxRlG9Ta0hm3pMXkoqZ+8mf3tfLtDCyr91qmOFq/3w9dCXB8jzWdrLaT39ZFG9Ha
	xnmGXwk+EnhQaItSIOibMeRMi8TW8KHu9oxlU6WkwKs23EoWPH6dX1A+LtAw==
X-Gm-Gg: AZFdTZcu62x/0U6Vt0iCJ5yKbVVPtPNu8wJt/mVas/cuDjEB/gDD8kRGL4a5lVEpJmB
	v0VDPLc44kBlDWe2b89Z1uMKXMRNYGQ0Is5j9Tahp7xJwwTx8qwmByTG3tfx9047nFvP3E9Av4M
	nTH59k+9UnjDtvNAKzh0g4B5+1z/xHnsiG1hoDLwVu/GO6CDKuxeCgMxzmAlWL0Grij85smzm1L
	80a4Zsx/Pk1Q8/qrS0BWs8ytMN1+EyNZq75Srav
X-Received: by 2002:a05:690c:3693:b0:8ac:8a2a:c387 with SMTP id 00721157ae682-8b5204c515bmr62842627b3.66.1795690295583;
        Thu, 26 Nov 2026 02:51:35 -0800 (PST)
X-Received: by 2002:a05:690c:3693:b0:8ac:8a2a:c387 with SMTP id
 00721157ae682-8b5204c515bmr62842577b3.66.1795690295135; Thu, 26 Nov 2026
 02:51:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:51:22 +0100
X-Gm-Features: Aa3M54pQ2uaU2yCEg8a4QqI2HavQv0Uy7ozPZ-cEqERpePDjv4Zn5gDUwphwyCc
Message-ID: <CAGgiveUw4dpc5Qgucn4sSJ9F4caW4NAnRsvD0MjKFfcdmJ+bbA@mail.gmail.com>
Subject: OP-TEE GitHub organization membership cleanup
To: op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX1gZv4RYpOtre
 iIRT99OuqkEiCM7R0X8SD1tDU95TsOaF1qwXlY95KGJoW1Kzz6RQ01sH6m1e+0XzxzbBMcV441S
 EkrWXuYNMu+FFb+BqZfTzW11aI0hT8Q=
X-Proofpoint-GUID: IGuR7duPNpQV6hzhP1I6q59njzdOacpj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0MiBTYWx0ZWRfX5XMHJBqge2H6
 yw0XcHS8ZpTYH+z8q00XctxSZWbJ7T73Qu/0dFZnptfoTEiOnWEowF1YWQDcmz93gZtfp9q4mc/
 ewC9r6dtWLYk9od30NKw/pSU8INg2DXXXJbigJ7MzHlrh/5iE9vBpOD6eR4g/tCDKh7KLrP5xv1
 HKIUXXRIIvwikYwOEkfpEjkkMenEs/q+SadPI9SfUAusx2bibp780ygs/gFPEFgcKH6Fy3p7loQ
 zRDQe3PsAToM5w/GoFL2B41cbs2HV+LSZ7i7zfcnci/CvNZO251GjSryJMPXVSyYqf+6j9A4CaM
 04PEnVmquI5WVuYgkbh2D+g0O+f6GPEU62wgDLTzkpeFsuR9pbsTrz/PmC2RHeE0JihLBFRj0+8
 h8ygzFJVgb0SuIMo2iD3E6H50rNqnnPlTlNsG6T/Gv/6FMEt9YqRqz2SS7KA1QUDvgcdiZB05oA
 PFPt1b2zmx7yHT4BPWA==
X-Proofpoint-ORIG-GUID: IGuR7duPNpQV6hzhP1I6q59njzdOacpj
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6b080f38 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=Op7MD-YmTCeGYbXb3ggA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.89 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	BAYES_HAM(-1.79)[93.74%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BDE1544ED3
X-Spamd-Bar: -----
Message-ID-Hash: 4Z2KPYIJT4OXB4AC7P2GDVBWFW7SW2P6
X-Message-ID-Hash: 4Z2KPYIJT4OXB4AC7P2GDVBWFW7SW2P6
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4Z2KPYIJT4OXB4AC7P2GDVBWFW7SW2P6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi everyone,

We are preparing to upgrade the OP-TEE GitHub organization from the
Free tier to a paid plan. Because the upgraded tier is billed per
organization member, we are auditing the current member list and
removing accounts that no longer need active organization-level
access.

All OP-TEE repositories remain public, so you can continue to clone,
fork, open issues, and submit pull requests as usual without being a
member of the organization.

If you are removed during this cleanup and still need write or triage
permissions on a specific repository, reply to this email.

Best regards,
Jens

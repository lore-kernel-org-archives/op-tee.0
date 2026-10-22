Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C4606A319
	for <op-tee@archiver.kernel.org>; Thu, 22 Oct 2026 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=A+R28REn;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BHg+lhvy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fp6F2kxR
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 896C645386
	for <op-tee@archiver.kernel.org>; Thu, 22 Oct 2026 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792672128;
	bh=AF+wNjriGNbcWWe1us5+uH5IHiU5H1JqHQpL96sAfRw=;
	h=Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=A+R28REnvN2hx+tbCGKHOiChmnpMzx5cbdW2TqCuvMSyzywnU1vufT/oMEWvXmaMG
	 bXqxRkslHpIAIu4qkQsmNM9nDlkUTsErZ9AqtUidE7M8t6jFhrxhOK7XqIm9jrTCGF
	 nXc6PR0iKg+bJVx8S9Ut799GzykGZlwy6iHXZ2tt3uvDN49uUneOw0kYuBIntdpyjZ
	 vEBXpt4Nno5TKaisX8SB6P57fhavlL4h6/8RweX3WOWSu6kIcJ0kgqrimq6QN0kQcm
	 H9yr9fAi/8BIUkMafJ/jyh11Fq97CRNseeYTIVjJo61mP7DztPbWyv+S556QcYufji
	 G40QLFO6sLkcA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EAAE744DA0
	for <op-tee@lists.trustedfirmware.org>; Thu, 22 Oct 2026 12:28:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BHg+lhvy;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Fp6F2kxR;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MCKvow3795794
	for <op-tee@lists.trustedfirmware.org>; Thu, 22 Oct 2026 12:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=AF+wNjriGNbcWWe1us5+uH5IHiU5H1JqHQpL96sAfRw=; b=BH
	g+lhvyGnWI3RFuA/wm2Qdxh0G3ZB+cu1htp/wgjBCuStpcIUBjfqP7Dzr+KN0ct0
	qWor5rRUXyGI1GUiEPBA4Ln2HjBdP3F/FgOBDWRSvujNFI5HY2uk6wo88DW8K2Bc
	vbGGyY72ZQSSw6tIx/cMUVyHK59GjhXq1O+y77wHijfSumF1YmWOsNYNDh/veLh5
	isza6DDDgJf6TqT5P/qI6+ZY2Z+cOhE6+Y26pihkr1yxi4N+jKg4ey12NwgseRm4
	4LZ2wUj+G350lWYshfR8fDTMNlxZL5O1GJ3T8l0gOV/bdWxatFFYBMvnO01v8TU5
	wLqus4TJiEQ41TxFqj2w==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93au7rx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 22 Oct 2026 12:28:17 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-677c4ca22c5so2545666d50.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 22 Oct 2026 05:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792672097; cv=none;
        d=google.com; s=arc-20260327;
        b=UUCtSrd2F6f07v8EmLWly4hKGvPJ2O1Sf/6jT2Mbt4cUUoF0rvrQ2ceC0Cdrtb7zD0
         Vx1n2cSgXxiwqInHlYwFloq+R+qcp2WliKpaHFbWjXkxfPnOKzJlGoAueCeQBYa66fZ0
         TrGWXr4VH6txKgtrGuvc2DjbkuFcV2QZWpPLoAFYrT7Y8utGyitXOiHcXD5ZmKB4nFvh
         ON06guCab1w7n4w2pL9UVgeJXNk6StjCHFYw0Qlzq/E6DhBnA3BO+t6Hj3sD+Z30mwOi
         s2e89Moeu4JHQ6lpriBws0vg50ZImpf1kYMiIKOLeBm722fNvM/PTEshKp8ApuScQzyC
         o4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=AF+wNjriGNbcWWe1us5+uH5IHiU5H1JqHQpL96sAfRw=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=V4PbTdSIr2qvQhpjLJg/vyNC8rrY+wpIMxXdTpMiDzGT5TCUnNYmg5hnI68IAoX0hF
         HclFC+MOPyS2AJkONHmXb1MDm/8F4cKGXvcMhvR9LEuwNM4JZE+z9yYVeyBEJ3iihTo5
         FVaPCbm8n/4KasvP7XqRg1pzlC+CVT+tnF1NT5GQszoqgWTszjR1XBBMscNM4i7DEk1h
         Suojur9b1mo53XYmnQo1cH4Z8FOyQ6rf+B/+mVi6aXnFjrXbE9hBdSxZaB6GrD8SRhJD
         ofvB1effI2EPUSt24s4iy74XG43NlETDphUIHs0m4zbumBHFXtRcLdqsETfa68N5wAjK
         qjKg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792672097; x=1793276897; darn=lists.trustedfirmware.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AF+wNjriGNbcWWe1us5+uH5IHiU5H1JqHQpL96sAfRw=;
        b=Fp6F2kxR1m6GJFpSsvrJzdnqfJFOahjfBrJLWgqtyC7sL+nOjCN3fm+27dO7vKSyZC
         Fmy7SjfnXHFXa/J/kTDQVqCSArv0Wcj0xd65tlBs6D1jr9EOQdoccztnDltPRqUejZHT
         XxH0VqJS21Cz3g4zo5PZXMzMr2v1HHm++6/91vBpEOtipNGxL/2TiHdjpVeV/eAf/xpd
         zh5BV9ccYnds1V9eDRqGIc11oINUDkCORqScudOMwMaL73Z3agHBKEfsMQgZI8wTPRMV
         +GepyEVhipREPBNl46IC117yFJ0j2T36XIFZcUTpMbik4QrTijJ6TSArnfmx7R6hRt7f
         eVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672097; x=1793276897;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AF+wNjriGNbcWWe1us5+uH5IHiU5H1JqHQpL96sAfRw=;
        b=KKdV+uhtaFPoQoETvyBSbpoWb05f8WTpsBcnemntuxbSdsOvolDqo8ufj6OFnoXE8N
         ImhA2L2X9mCA+QU78mp0co2h1+fLtWkmH1nHPkKdXLs74feYKbD6AKbVHE986FVFKe/+
         f5VTrFuUdAWDgVEpS7uYpWldsMmf3bsb5HnA5IcxEH9bGTWqgTjib1CpeCCjH33ClEuP
         HQNz11sHhGrPJoFPqNthjflPTMB0o1Ane0hIMDZ++WtSPFWnzmjCmCE++i/g7xkt+5Vi
         jtdetp+tjspwZocDyqZ7DmocLQ3hYIJVsANbMboFuYK4JdVipWxXgnPtNjmqTnkFaipf
         Q5VQ==
X-Gm-Message-State: AFq9FYJ5kIgaN+puRdQkXGl6+HpYRKRNwzgO6QA+IiwzrfOiCVzYhWpy
	fgRKLFlkP4trDbwU7FG9CQUXagHwTlZ7WJydVcj0t4gkLxzejHYEcZH+4z9Tjyfk+vqGSxkPoZA
	7NLoYmrVUPvK258UUL3R0FTSIts4+FryIkPWSqO79gume696BQH3CNUmpaywFNrQrxYNpuWAuY3
	ke6jTGXAVrHn6UsazE0jCdTjBL1skMga05QNk3/Ii27nz44YJ7uZD7RtXAXfsj
X-Gm-Gg: AYBFou2YO9REpMT+xh1uLcpVtED6Vwnirggch8BLbSmORr2G0EzAk5md7DCCgsfdT1A
	+fSri4TaIg+LB3GA0OJaG4l5qO/5CAQsu/6NuS03vTzxXzslJYSyGvjxKGGg0H7F8HH7R007qEL
	dd9onNbEjU2EjxE58ESymB3ptPQUhr19bzFuhNjq5sW53Z4SR2uLv1HQg=
X-Received: by 2002:a05:690e:142:b0:679:8c5f:3fcb with SMTP id 956f58d0204a3-67a0e4ea5e9mr1821990d50.39.1792672096843;
        Thu, 22 Oct 2026 05:28:16 -0700 (PDT)
X-Received: by 2002:a05:690e:142:b0:679:8c5f:3fcb with SMTP id
 956f58d0204a3-67a0e4ea5e9mr1821980d50.39.1792672096167; Thu, 22 Oct 2026
 05:28:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 14:28:04 +0200
X-Gm-Features: AclHuK-J4nMoBawvILEiG_SjYbqWbMldVjNs0mzzGRt4mgiZdp3zB76pDSkf2nE
Message-ID: <CAGgiveXVs8o-eN3iGLVU3jY8-1Mu28dpo8kdnCyxB6q8P-cBhA@mail.gmail.com>
Subject: OP-TEE Contributions Forum, monthly meeting October 27
To: op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfXzC4jspDzDZit
 ZPGcEva9J9gTTgx2/jSAVmKtpgz6GFTig0kf4zQveBYkXsdS44BXbpBVUWfXef8mYjK2e7QQTlK
 3t9vkKnFOYQtYZob6FZQ3kg+ijoY5ZUaHstZhOs00bY42FnS2WhsXI66/ieEsed1DcyIUYTNApX
 v5C15VbuDr9YxuV6Scey5TVkevE5ZBdeIJ+ieZTAySUBQgjtch69Axr2O80Espo3P9AGzZpUH4+
 vNKhcrhYUiPssKXrSW78GR3fZiImY530t4RxutPEDboHZVuSsUvB7Zne5JoPod55sB+05neqjFd
 UmQ/IZ9ecU39iNnnbqV3MNXtfhfebr4NvmuT2yeKMdCBBWCtZrEvJtW67NP7ZoH6UKbiV6QsVaj
 7A26G1m6dGZpxz2+ssIiN+QtX7AWNGN6OkFodX/aQdTzleDg7dxOo3qvENASoVPs3WRkzaWJ+uU
 PImqT6PnEHddPDqYC8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX6lLr8JQCxz69
 WaKmYgDtdK8b5WU2tgsn7H2QlROh5gT6JipIR8+XydBkW/eDu2Q5SEsoPaG7FQwav3BrQvpIZLa
 vznRVF5g/OSUzVE0RKkVe62emiItrNM=
X-Authority-Analysis: v=2.4 cv=QPn91QLL c=1 sm=1 tr=0 ts=6ada0161 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=b45o4kL6AAAA:8 a=NEAV23lmAAAA:8
 a=L-k6HrDoMRJ0UDwQnwwA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: qLMWmz1d09ysfHa4d2KOAujCv0uQiNBk
X-Proofpoint-ORIG-GUID: qLMWmz1d09ysfHa4d2KOAujCv0uQiNBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.02 / 15.00];
	BAYES_HAM(-2.92)[99.65%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.70:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EAAE744DA0
X-Spamd-Bar: -------
Message-ID-Hash: ZU5AKASTTBFTLC6IDRHYFXVCD4YYPPIP
X-Message-ID-Hash: ZU5AKASTTBFTLC6IDRHYFXVCD4YYPPIP
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZU5AKASTTBFTLC6IDRHYFXVCD4YYPPIP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tuesday next week, it's time for another OP-TEE contributors' monthly
meeting. For time and connection details, see the calendar at
https://www.trustedfirmware.org/meetings/

We've released OP-TEE version 4.11.0 :-)

MbedTLS end-of-life April 2027:
https://lists.trustedfirmware.org/archives/list/mbed-tls@lists.trustedfirmware.org/thread/YPIGCB7WN6GCHOGEGKOJXUYAP7OK527W/
No urgent action needed. We can stick with MbedTLS for now, but we
can't maintain it.

CI updates and the way forward:
- Replaced the branch push trigger with a nightly CI job and a CI
status badge in the README.md
- Switch and renovate CI image https://github.com/OP-TEE/optee_os/pull/8021
I pushed the patches to a ci_testing branch in optee_os to give it a
spin and to generate the needed ci-image.

Rebased optee out-of-tree kernel patches on v7.3

optee_client for Zephyr, etc. https://github.com/OP-TEE/optee_client/issues/428

Any other topic?

Cheers,
Jens

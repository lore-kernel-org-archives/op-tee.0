Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662ED606A31A
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gmQCPa51;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QK1FoExn
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B5D17454D0
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 13:44:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gmQCPa51;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QK1FoExn;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 358824449E
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 13:44:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDKrb52369037
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 13:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=QEsyPSqfBi1qnePeomROL/gCHgQlxeCZvEye0CNVxZY=; b=gm
	QCPa51G95OUputvcpVOOAqK6OfQAPEDMTHC5vW3mk/57G/jjbabNaEHEJiWWOIq5
	KlxopPvIPNmt7HXnrEilRVBb/7AddF5Za32k7WvSujijdcX4+etJEB5HlKRa2XFM
	cl2bw7oOS/E2Ior2r99jCac3M7x3BM/7IMbyv0qYCGkt+HDtNCOSvivyL77Vtd/H
	lCg+LHvmVmL0qxgkHxXOb0bkma6B24B/Sn8VN4gmymd2AcdVtts8rZjqa1ZJqpzs
	BdkkSS0nHU9wjDlRryyHZWwQvu19+z+mnoO+ieYCmLYAVLahEBU0ChgieZUQPytZ
	3p48GgIqqm8SBkX3BVxA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1p9jpf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 13:44:43 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b0f1c06332so49694837b3.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 05:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795441483; cv=none;
        d=google.com; s=arc-20260327;
        b=DaypTjcX+wmn/jaMcvbxGz7/l1DtjRJtE2K0V3F1V1wFIYc4FGpfyAgFc2dczZCexy
         bDDnEvY3dSKc/eEPtwQbu6iVT4bdd+Ii8SHMos9P8rbhOqRONYxdw6NAdNZUaaNk6pxj
         uiINj9+kVq/ujOoYE0TNg2S37+ONxFSSgubfpKKKBEyk4yoAqSXmuLTOToiUQnD+3SXc
         /WIYL3o2hhUOgxsJ1+IHHC4Rt6g9VGKqOydFy15PnnsKojtqz2li7TgQXvIJa7G1MVbn
         gz7vttK+xyaXgH7LgaFrtgqVkx1TxVuFk44VG7hAO5h+/YrhnWkkf3BJDKwOMf4pPMVi
         Zsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QEsyPSqfBi1qnePeomROL/gCHgQlxeCZvEye0CNVxZY=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=MzlJrdDcu/uWs1e7/txMQinTQN9NdRPxuQTvCr7aCducxt0GS0AOYMyIPsAXaCK1Tx
         /ewqf96pQve7ogYnkjaXrrZVOLsZ7gR24A0SFEGRTCplr3g8BUNz+arTcLYTNKhZ/RyI
         5k7vhCOAMWxSrUSP7JhIeEA0++bcHeMXSVRGtcH+KyBg9+OSqrmpmUwwwKVDYSiNENu4
         yTsfXTF+DwU8U6MF6D9+KTmrme1unrd6JIhDc8Za2ww6i8XyM6qOYSHum8Xkpfr2KuPQ
         vj+gRz4cdWWkO1UXrecuXVrcSliH8kEIwBjWKi5TMvffwJ/TWI/nTt3XhBsodpgDjNUC
         uRYA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795441483; x=1796046283; darn=lists.trustedfirmware.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QEsyPSqfBi1qnePeomROL/gCHgQlxeCZvEye0CNVxZY=;
        b=QK1FoExnpkUcyZAa2zMylaKWS79b2t+e+S1FDRPuSpizmedkvK16WlOJ1xo29d9Hay
         DMFFPJdQ58+5LRnj7Peg3Xmf/7U3rEX6gkrTOdl1aLrDpm8eD5DpvyRNnUepHzPtSt8+
         NLMolpTYPj364cviNltmhxxroanWtBqQjtwgB9HtObbUoUB0Tig7VIgJTEA1u7VLFQa8
         CUtdNyzE88kf4dbB2lQYDhuBbATwUDNDRVyp7gFPzcYTY3TUccPgq6/KeEK2ACJ3nAhW
         5L8tc11azJwip/rsGWkBV8mJ9MEDrri3JLc+rsZkgo5BfhCRQl28uHp/Bwemjj2TVbZm
         AuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795441483; x=1796046283;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEsyPSqfBi1qnePeomROL/gCHgQlxeCZvEye0CNVxZY=;
        b=kQMUFUzGq2+5h4jO0dqFxnQ58xW3g7/+o5QjzGwhRuf2kperb97r0opVT63QkMa1JL
         DTOfuDjWQhQe0L/9fQJYPqxnY16ZbeKhIJFI08yF+a+s+7XE8yzQOEl92BOJiPXVKp/l
         jMRwVGC5amVdHBN4Z8ZdyK/0K7AGveW7YWeNatsB6mrAuAUT5rOAhE68a1iBANStbVNY
         vR1qPc9gys3MJ3A1wPl1a2WI8u2Ylcfpwa/FlmKjdyF6I/isOexCBJb8B5ScZi9ZO7bj
         H3wDty77QMlumfwZSZ/zpHgHARn3Gh/8Xw6c3pkSh/ThehCJo/BKzH1Nl5WK603o4+sh
         uyJg==
X-Gm-Message-State: APuU4Z8AMnynnq4yLTnO/xR+cXo6BCvhGjAV0C30kr6F561C/SjDxNk4
	u/Rx4zZBL1BtdzWoRbbsbJqXwbgFYUQhC262qLW06iTpdAENUyctIrM2QTSVPLNd399OkIXgLEv
	ze3ZCfld634emRqo/98fdTCE6M9o4DSBBS0EWj0yYCLi9rak1gY2ABR/9HgWR9/KNQaS0j4ZNQE
	eFTJRQH/K7ObrSdl1rpyRCL3q+1Oq0rYOY7xaTY3Wvjdamcj34DvRAPxCNig==
X-Gm-Gg: AZFdTZeSdBVfLQVspLU58m3TrxnlnQYdafvKuBwpjINpXaRqQ3DI4xqE6t+CJqb776K
	Q6/wprkJrzOMGLPGRs41UXXi5x4JJsadLok4ag8OfjfI/EsEVPgdfls0jDkUUJ25wVFjwcPWTwH
	qghsXrxlpabMbkjjxc3ilej/5+yNHRuiqvAXanwacuXD6b+gnViWOemJ4xvRM8WIRFtATbvjhsC
	K5ajkPNULR5M6HvdOMB/ADgYxFvYYV9bm6iH1jd
X-Received: by 2002:a05:690c:3084:b0:8b3:3854:c294 with SMTP id 00721157ae682-8b5204e44d8mr44770337b3.46.1795441482995;
        Mon, 23 Nov 2026 05:44:42 -0800 (PST)
X-Received: by 2002:a05:690c:3084:b0:8b3:3854:c294 with SMTP id
 00721157ae682-8b5204e44d8mr44770297b3.46.1795441482562; Mon, 23 Nov 2026
 05:44:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:44:31 +0100
X-Gm-Features: Aa3M54pTci7ZtvWQvUrKQj7hWg_hiORWDkwo9UZzYb2DnpGNWIEptTI1vVqoEEs
Message-ID: <CAGgiveXziuHckbSx8SfhW1e_DH8UFxb85+rteRHY-Q1Obb++cw@mail.gmail.com>
Subject: OP-TEE Contributions Forum, monthly meeting November 23
To: op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfXw9j5yHZLi7NY
 vA2+Ym6PnrB+GO6strRI60XDDgstvg4UAgrpHXGdKjGobTxSIEDQ1MN/0ZK4VodddY32IBxtLct
 ZNkya/7QOB7jyzQP6d+2CotgP1HSrQeQvbrV7eXXR/P4+CViTWW//gB7QP4yUGddf5kDS9pxAr0
 ZECRt3uW9GCTfGmUwK+rqKVW2cWioJwf0o++jbhoree+v/M5BzrJkWBbw06BX+/uSA8TidXuC//
 TtVmJbUxGujq1PYiVpsm9K04AwdFh4d/9kUWFQXsfy3RpDx0KxtRwXCbfSK1GFJ5pt7NUlHcTwb
 UKXbIntoqR3eOicea3/5g8NMXiLNPW+jndX/mGjTCxAiCpJ8n1hp/TGqXopKO7OHQOQma/o/GeE
 ZzYn7AjYBXKN84S2t7MJZtV+YXWju+leDuSOyuHtIDgoRyWdcFpdWeBjx30WPBIKL7vlju7LU5u
 Q85jT5B5WJcq0BSKFBg==
X-Authority-Analysis: v=2.4 cv=AeIkjHXG c=1 sm=1 tr=0 ts=6b04434b cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=b45o4kL6AAAA:8 a=e2OMKcPlyt9ly3soZxIA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: 0MrarE2W96YqCra6Am6GzzYGBJDwKUmq
X-Proofpoint-ORIG-GUID: 0MrarE2W96YqCra6Am6GzzYGBJDwKUmq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX6vRqiO0kROZM
 WPTOu/w2zcwFLvQSKl7A8hWU//hX8X2dNQkX6WkR0u0hsOBG+nna8nQUoGJqsOSfA0pXFB3rO6t
 y1HUG3vJaeJkpQheaBlYFHK9C5JVzBw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-2.90)[99.59%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.128.198:received];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 358824449E
X-Spamd-Bar: -------
Message-ID-Hash: 2Y2WQ2LQAJOO6HBRAPL7ITUD3IBPMOOC
X-Message-ID-Hash: 2Y2WQ2LQAJOO6HBRAPL7ITUD3IBPMOOC
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2Y2WQ2LQAJOO6HBRAPL7ITUD3IBPMOOC/>
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

Hi,

Tomorrow, Tuesday, it's time for another OP-TEE contributors' monthly
meeting. For time and connection details, see the calendar at
https://www.trustedfirmware.org/meetings/

Topics:
- Merging CI updates, and more are coming
- Adding more generic OP-TEE reviewers in MAINTAINERS


Any other topics?

Cheers,
Jens

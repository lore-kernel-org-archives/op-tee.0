Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F9606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=ExjkmuzU;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ha46cxYz
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E476A453C9
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793877311;
	bh=ejXa4bXFZIeRwcnca5O83Ge4yrWKFSQyxTe8NEOcvVE=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ExjkmuzUrmhmJ2Y1ZdjszW2DK5waaBmHyXTKK2W1bWAxT/icnyfuqYAgVpl+u0yN9
	 okaeZcCzjVzKcjg7C5MMs44/wU16dc6jKIJY2Pu3lANSZT63RnFpk8VRwagFTS+h7C
	 /RHqWYW3lwNtUxcoDDXT4Gz4VeXQtqjqqLGEJXuP3BxR/15kn8FLWvMJMU44pvpuex
	 IWsL6rCpm7rlgG/br753xt908MD5tM4kFrT8tVFKE3QaJ/tDHep/uSEJrTxLNzmHaR
	 N7WG8Zyo7XP0zClGwvrZeCY49ADNud/DOfF3vPCBA/DPEIeryS8JiEaaCUvi+eO5Cq
	 DL/bxtHRWCGfQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A9F4D45486
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:12:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ha46cxYz;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2989140431;
	Thu,  5 Nov 2026 11:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66FC1F00A02;
	Thu,  5 Nov 2026 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877127;
	bh=hcZ6WPxWQqwmRStYl6C8MSMaB4AuiG3AzHw/8ODrNB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ha46cxYz+f5O3PZ62l1EzAf2DcXdcDWFFCYFdsNiJ/EfMHBI9iN8WJBpEa2t/fhbp
	 YiDJyRyaTJOCXDn5V7ZQEodwI+80StGeRoeKjIa5fpnYD3nvFBIn4/eEas/jUSlsOe
	 TGo3JnveEd3aciHp+qSkSR+9noMtG6nKmUKsXo41W20ukXVNrlusIeeY/te8Q75sxc
	 FUjFnZc/8QSWNaBl1g9bnUKYJQTSIIw4Vob18CUplfhJ8L9qaCXRrSjsNLqz+gZkuy
	 yzsRj22YTXapgoeB58Kugn/8IjRan4j3psVvV6t7Q+Fop0YLlligZr6+nDT9FD1O4E
	 Q1YdgnuE01paA==
Message-ID: <sashiko-outbox-198923@kernel.org>
Subject: Re: [PATCH v4 8/8] selftests/dmabuf-heaps: Add dma-buf memcg
 accounting tests
To: "Albert Esteve" <aesteve@redhat.com>, "Tejun Heo" <tj@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Michal
 Hocko" <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Benjamin Gaignard" <benjamin.gaignard@collabora.com>, "Brian
 Starkey" <Brian.Starkey@arm.com>, "John Stultz" <jstultz@google.com>, "T.J.
 Mercier" <tjmercier@google.com>, "Christian Brauner" <brauner@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, "Jens Wiklander" <jenswi@kernel.org>, "Sumit
 Garg" <sumit.garg@kernel.org>
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-8-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-8-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:12:05 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A9F4D45486
X-Spamd-Bar: -----
Message-ID-Hash: 2FUU7SUKPWQPLF4APGI5JQELRWNF2435
X-Message-ID-Hash: 2FUU7SUKPWQPLF4APGI5JQELRWNF2435
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2FUU7SUKPWQPLF4APGI5JQELRWNF2435/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: sashiko-bot--- via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] selftests/dmabuf-heaps: charge_fd=3D0 and unskipped EOPNOTSUPP i=
n XFER_CHARGE test
- [Medium] selftests/dmabuf-heaps: pidfd_alloc_supported() treats EOPNOTSUP=
P as supported
- [Medium] selftests/dmabuf-heaps: missing memory controller check in open_=
self_cgroupfd()
- [Medium] selftests/dmabuf-heaps: check_deps() runs before handle_build() =
in vmtest.sh
- [Low] selftests: cgroup: leak of child_cg on cg_create() failure in test_=
memcg_dmabuf()
--

commit b3c8a8b74499074e19a368c4979733bfe47e9d56
Author: Albert Esteve <aesteve@redhat.com>

selftests/dmabuf-heaps: Add dma-buf memcg accounting tests

This commit adds selftests for dma-buf memcg accounting via charge_fd and
DMA_BUF_IOCTL_XFER_CHARGE in dmabuf-heaps and cgroup/test_memcontrol, along
with a virtme-ng runner script and Kconfig fragment.

> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index 0ed82347044ed..3c95bcabee2bd 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
[ ... ]
> +static int test_memcg_dmabuf(const char *root)
> +{
[ ... ]
> +	parent =3D cg_name(root, "dmabuf_memcg_test");
> +	if (!parent)
> +		goto cleanup;
> +
> +	if (cg_create(parent))
> +		goto cleanup_parent;
> +
> +	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
> +		goto cleanup_parent;
> +
> +	child_cg =3D cg_name(parent, "child");
> +	if (!child_cg)
> +		goto cleanup_parent;
> +
> +	if (cg_create(child_cg))
> +		goto cleanup_parent;
[ ... ]
> +cleanup_child:
> +	cg_destroy(child_cg);
> +	free(child_cg);
> +cleanup_parent:
> +	cg_destroy(parent);
> +	free(parent);
> +cleanup:
> +	return ret;
> +}

[Severity: Low]
Does test_memcg_dmabuf() leak the child_cg string buffer if
cg_create(child_cg) fails?

Jumping to cleanup_parent bypasses free(child_cg) under cleanup_child. Shou=
ld
that error path free child_cg (or jump to cleanup_child) before cleaning up
parent?

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 1d49df6719198..90ef14d2ecba0 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
[ ... ]
> +/*
> + * Probe whether the kernel honours charge_fd in DMA_HEAP_IOCTL_ALLOC.
> + */
> +static bool pidfd_alloc_supported(int heap_fd)
> +{
> +	int devnull_fd, dmabuf_fd =3D -1, ret;
> +
> +	devnull_fd =3D open("/dev/null", O_RDONLY);
> +	if (devnull_fd < 0)
> +		return false;
> +
> +	ret =3D dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, devnull_fd, &dmabu=
f_fd);
> +	if (dmabuf_fd >=3D 0) {
> +		close(dmabuf_fd);
> +		dmabuf_fd =3D -1;
> +	}
> +	close(devnull_fd);
> +	return ret < 0;
> +}

[Severity: Medium]
As reported by Sashiko on v3 [1], won't pidfd_alloc_supported() return true
when CONFIG_MEMCG is disabled?

When CONFIG_MEMCG=3Dn, the inline stub in include/linux/memcontrol.h returns
-EOPNOTSUPP for any file descriptor:

static inline struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
{
	return ERR_PTR(-EOPNOTSUPP);
}

In dma_heap_ioctl_allocate(), that causes DMA_HEAP_IOCTL_ALLOC to fail with
ret < 0 and errno =3D=3D EOPNOTSUPP when passed devnull_fd, so
pidfd_alloc_supported() treats the feature as supported and the subsequent
tests fail with EOPNOTSUPP instead of skipping.

Should pidfd_alloc_supported() check ret < 0 && errno !=3D EOPNOTSUPP?

[ ... ]
> +static int open_self_cgroupfd(void)
> +{
> +	char cgroup_path[PATH_MAX];
> +	char buf[PATH_MAX];
> +	FILE *f;
> +
> +	f =3D fopen("/proc/self/cgroup", "r");
> +	if (!f)
> +		return -1;
> +
> +	cgroup_path[0] =3D '\0';
> +	while (fgets(buf, sizeof(buf), f)) {
> +		char *p =3D buf;
> +
> +		if (strncmp(p, "0::", 3) =3D=3D 0) {
> +			p +=3D 3;
> +			p[strcspn(p, "\n")] =3D '\0';
> +			snprintf(cgroup_path, sizeof(cgroup_path),
> +				 "/sys/fs/cgroup%s", p);
> +			break;
> +		}
> +	}
> +	fclose(f);
> +
> +	if (!cgroup_path[0])
> +		return -1;
> +
> +	return open(cgroup_path, O_RDONLY | O_DIRECTORY);
> +}

[Severity: Medium]
As reported by Sashiko on v3 [2], what happens in test_alloc_cgroupfd_self()
and test_xfer_charge_cgroupfd_self() when the test process runs in a cgroup
where the memory controller is not enabled in its parent's
cgroup.subtree_control?

In mm/memcontrol.c:mem_cgroup_get_from_fd(), resolving a cgroup directory fd
requires an active memory controller CSS on that cgroup and returns -ENOENT
otherwise:

	cgrp =3D cgroup_get_from_fd(fd);
	if (!IS_ERR(cgrp)) {
		rcu_read_lock();
		css =3D cgroup_css(cgrp, &memory_cgrp_subsys);
		if (!css || !css_tryget_online(css)) {
			rcu_read_unlock();
			cgroup_put(cgrp);
			return ERR_PTR(-ENOENT);
		}

Should open_self_cgroupfd() verify that the memory controller is enabled on
cgroup_path (or should the callers skip on ENOENT) so the tests skip rather
than fail when run outside vmtest.sh in a non-root cgroup without +memory?

[ ... ]
> +/*
> + * Test: transfer a dma-buf's charge to self cgroup via DMA_BUF_IOCTL_XF=
ER_CHARGE.
> + */
> +static void test_xfer_charge_cgroupfd_self(char *heap_name)
> +{
> +	int heap_fd =3D -1, cgroup_fd =3D -1, dmabuf_fd =3D -1, ret;
> +	struct dma_buf_transfer_charge xfer =3D { 0 };
> +
> +	heap_fd =3D dmabuf_heap_open(heap_name);
> +
> +	if (!pidfd_alloc_supported(heap_fd)) {
> +		ksft_test_result_skip("charge_fd not supported by this kernel\n");
> +		goto out;
> +	}
> +
> +	ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> +	if (ret) {
> +		ksft_test_result_fail("Allocation failed %d\n", ret);
> +		goto out;
> +	}
> +
> +	cgroup_fd =3D open_self_cgroupfd();
> +	if (cgroup_fd < 0) {
> +		ksft_test_result_skip("cannot open self cgroupfd\n");
> +		close(dmabuf_fd);
> +		goto out;
> +	}
> +
> +	xfer.charge_fd =3D cgroup_fd;
> +	ret =3D ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> +	ksft_test_result(!ret, "XFER_CHARGE to self cgroupfd %d\n", ret);

[Severity: Medium]
As reported by Sashiko on v3 [3], won't test_xfer_charge_cgroupfd_self() fa=
il
with EOPNOTSUPP under default kernel parameters (dma_heap.mem_accounting=3D=
0) or
on heaps that do not set exp_info.memcg (such as CMA heaps)?

Here the buffer is allocated with dmabuf_heap_alloc(), which passes
charge_fd =3D 0. In drivers/dma-buf/dma-heap.c:dma_heap_ioctl_allocate():

	if (heap_allocation->charge_fd) {
		memcg =3D mem_cgroup_get_from_fd(heap_allocation->charge_fd);
		if (IS_ERR(memcg))
			return ERR_CAST(memcg);
	}

	if (!memcg && mem_accounting)
		memcg =3D get_mem_cgroup_from_mm(current->mm);

When charge_fd is 0 and mem_accounting is false (the default), memcg is NUL=
L,
and drivers/dma-buf/dma-buf.c:dma_buf_xfer_charge() returns -EOPNOTSUPP when
dmabuf->memcg is NULL:

	if (!dmabuf->memcg) {
		ret =3D -EOPNOTSUPP;
		goto out;
	}

Similarly, pidfd_alloc_supported() passes for all heaps because charge_fd is
validated in dma_heap_ioctl_allocate() before heap->ops->allocate(), so
non-system heaps reach DMA_BUF_IOCTL_XFER_CHARGE with dmabuf->memcg =3D=3D =
NULL
and also return -EOPNOTSUPP.

Should test_xfer_charge_cgroupfd_self() allocate the buffer with a charge_fd
(e.g. via dmabuf_heap_alloc_pidfd()) and skip when DMA_BUF_IOCTL_XFER_CHARGE
fails with errno =3D=3D EOPNOTSUPP?

> diff --git a/tools/testing/selftests/dmabuf-heaps/vmtest.sh b/tools/testi=
ng/selftests/dmabuf-heaps/vmtest.sh
> new file mode 100755
> index 0000000000000..3574b71ca83e8
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
[ ... ]
> +check_deps() {
> +	for dep in vng make; do
> +		if [[ ! -x $(command -v "${dep}") ]]; then
> +			echo -e "skip:    dependency ${dep} not found!\n"
> +			exit "${KSFT_SKIP}"
> +		fi
> +	done
> +
> +	if ${SHELL_MODE}; then
> +		return
> +	fi
> +
> +	if [[ ! -x "${DMABUF_HEAP_TEST}" ]]; then
> +		printf "skip:    %s not found!" "${DMABUF_HEAP_TEST}"
> +		printf " Please build the kselftest dmabuf-heaps target (or use -b).\n"
> +		exit "${KSFT_SKIP}"
> +	fi
> +
> +	if [[ ! -x "${MEMCONTROL_TEST}" ]]; then
> +		printf "skip:    %s not found!" "${MEMCONTROL_TEST}"
> +		printf " Please build the kselftest cgroup target (or use -b).\n"
> +		exit "${KSFT_SKIP}"
> +	fi
> +}
[ ... ]
> +trap cleanup EXIT
> +
> +check_deps
> +check_vng
> +handle_build
> +make_runner

[Severity: Medium]
As reported by Sashiko on v3 [4], if vmtest.sh is invoked with -b on a clean
tree where the selftest binaries have not been built yet, won't check_deps()
exit with KSFT_SKIP before handle_build() has a chance to compile them?

Should handle_build() run before check_deps() (or should check_deps() skip
the binary existence checks when BUILD is true)?

[1] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
8-78d2c4cb8647@redhat.com
[2] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
8-78d2c4cb8647@redhat.com
[3] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
8-78d2c4cb8647@redhat.com
[4] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
8-78d2c4cb8647@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D8

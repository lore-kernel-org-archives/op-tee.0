Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB3606A31C
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=ejniXmMx;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+HO1/Ms
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 47B0945411
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794991296;
	bh=11QihuGmvwJ+J6UC3HTFsFQcatJCr+ScqKnqPtRg+uo=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ejniXmMxFsKNhxSr0NuStTde9ctXeGFm8Ejgu0GKi4eIoM88tWdAHZz/Yp1P7V8O2
	 G9r7CCnQLEIqo6Pui7sL1J9cWp+5gDxAUoBaE0dasp2/nHn/jUSIkrlldqMBTVp3nU
	 iljk6D4a35ar+W/Ue5aXSGKobEnNESPlTd+qr5qamZWGGGvduAWK5HYRtUQkcCy1Lq
	 HPWe1y1HFq3HI2BafMUD9nC5J6MXLiNXjeqxfP14MHOsmluk6qRmKuDJqP+/QTesof
	 4mSDrUoQGBNaYaLwqY2fU31tyJsOlH/rGVplVxHe7moJLiZOQAThc7eX9fp8yPbehp
	 2M1RblZeI3b2w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1D4DF45416
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 08:41:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+HO1/Ms;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5670C61F9B;
	Wed, 18 Nov 2026 08:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB981F000C5;
	Wed, 18 Nov 2026 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794991267;
	bh=l8GcV6uMWhHjYzBlHCWVuNIxepR4dKtsrwA8u33yne4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j+HO1/Ms/nwF1EMiL0j/MGCm9pQhh9e95zpbPWDLke8Lk4EGqbF5FynA6/WH1uCyW
	 zvl8lf0oyEqgLvHpylSqcRSI763UQKAo4dOR4su/0S4bbVoJaK4MHmbMvtj7RyFfjP
	 C5hhi9fdI5LIDCAiE8Tu40304b4zbVyzVetIx/AplgDNs2SS8nsbmbwzL/mr4RmrPf
	 EA2VLqJSNlC+x8tch5fYJGq8FjrbPQJClIPaQVtV2scUXcxvQhANBK85DlNyTvCV3n
	 7rHNOuLgTbBu6SmCy+FWr3Cbx3tgmyQvRsSUNFaq0AOemGG4d2KmZuvVVD/tPiyQqt
	 KbdWptMk1vnSQ==
Message-ID: <sashiko-outbox-220474@kernel.org>
Subject: Re: [PATCH v5 8/8] selftests/dmabuf-heaps: Add dma-buf memcg
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
 Garg" <sumit.garg@kernel.org>, "Philipp Stanner" <phasta@kernel.org>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-8-1ce975f2a9ad@redhat.com>
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <20261117-v2_20230123_tjmercier_google_com-v5-8-1ce975f2a9ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:41:04 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kvack.org,vger.kernel.org,lists.trustedfirmware.org,redhat.com,kernel.org,linuxtv.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1D4DF45416
X-Spamd-Bar: -----
Message-ID-Hash: UL2K3I65MQ2ZIR3RAC44YO2CNDFF42WC
X-Message-ID-Hash: UL2K3I65MQ2ZIR3RAC44YO2CNDFF42WC
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UL2K3I65MQ2ZIR3RAC44YO2CNDFF42WC/>
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

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [Medium] selftests/dmabuf-heaps: pidfd_alloc_supported() mishandles
  disabled memcg
- [Medium] selftests/cgroup: dmabuf tests read memory.stat below rstat
  flush threshold
- [Medium] selftests/dmabuf-heaps: open_self_cgroupfd() misses memory
  controller check
- [Medium] selftests/dmabuf-heaps: check_deps() runs before
  handle_build() in vmtest.sh
- [Medium] selftests/cgroup: test_memcg_dmabuf_xfer_at_limit() fails
  instead of skipping
- [Low] selftests/cgroup: child_cg leak on cg_create() error in
  test_memcg_dmabuf()
- [Low] selftests/cgroup: missing skip checks in
  test_memcg_dmabuf_xfer_at_limit()
- [Low] selftests/cgroup: unused MEMCG_SOCKSTAT_WAIT_RETRIES macro in
  test_memcontrol
- [Low] selftests/dmabuf-heaps: vmtest.sh creates TMP_DIR before setting
  EXIT trap
- [Low] selftests/dmabuf-heaps: make_runner() omits
  test_memcg_dmabuf_dead_cgroup
--

commit 9485d75462eea316c6a545e3ba3f2d0923e12b75
Author: Albert Esteve <aesteve@redhat.com>

selftests/dmabuf-heaps: Add dma-buf memcg accounting tests

This commit adds selftests for dma-buf memcg accounting using charge_fd and
DMA_BUF_IOCTL_XFER_CHARGE in dmabuf-heaps and cgroup/test_memcontrol, along
with a virtme-ng test runner script.

> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/tes=
ting/selftests/cgroup/test_memcontrol.c
> index bb673012dcf08..f612726bd9af7 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -27,6 +34,13 @@
>  #define MEMCG_FLUSH_BYTES	\
>  	(2 * sysconf(_SC_PAGESIZE) * MEMCG_CHARGE_BATCH * get_nprocs())
> =20
> +#define DMA_HEAP_SYSTEM		"/dev/dma_heap/system"
> +#define ONE_MEG			(1024 * 1024)
> +
> +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30

[Severity: Low]
MEMCG_SOCKSTAT_WAIT_RETRIES was removed in eb69e955de7b ("selftests: cgroup:
make test_memcg_sock check flushed sock stats") and has no users here.  Was
this re-added by accident during a rebase?

> +#define MEMCG_DMABUF_WAIT_RETRIES          30
> +#define MEMCG_DMABUF_DEAD_WAIT_RETRIES     80
> +
>  static bool has_localevents;
>  static bool has_recursiveprot;
>  static int page_size;
> @@ -1797,6 +1811,417 @@ static int test_memcg_inotify_delete_dir(const ch=
ar *root)
>  	return ret;
>  }
> =20
> +static int memcg_dmabuf_child(const char *cgroup, void *arg)
> +{
> +	pid_t *parent_pid =3D arg;
> +
> +	prctl(PR_SET_PDEATHSIG, SIGKILL);
> +	if (getppid() !=3D *parent_pid)
> +		return 0;
> +
> +	pause();
> +	return 0;
> +}
> +
> +/*
> + * This test allocates a dma-buf via DMA_HEAP_IOCTL_ALLOC with a pidfd
> + * pointing to a child process in a separate cgroup, then checks that
> + * memory.stat[dmabuf] in the child's cgroup rises by the allocation size
> + * and returns to zero after the buffer fd is closed.
> + */
> +static int test_memcg_dmabuf(const char *root)
> +{
> +	char *parent =3D NULL, *child_cg =3D NULL;
> +	int ret =3D KSFT_FAIL;
> +	int heap_fd =3D -1, dmabuf_fd =3D -1, pidfd =3D -1;
> +	pid_t child_pid, parent_pid =3D getpid();
> +	int child_status;
> +	long dmabuf_stat;
> +	struct dma_heap_allocation_data alloc =3D {
> +		.len      =3D ONE_MEG,
> +		.fd_flags =3D O_RDWR | O_CLOEXEC,
> +	};
> +
> +	if (access(DMA_HEAP_SYSTEM, R_OK | W_OK)) {
> +		ret =3D KSFT_SKIP;
> +		goto cleanup;
> +	}
> +
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

[Severity: Low]
Does this leak child_cg when cg_create(child_cg) fails?  Jumping to
cleanup_parent skips free(child_cg) in cleanup_child.

[ ... ]

> +	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc) < 0) {
> +		close(alloc.charge_fd);
> +		goto cleanup_heap;
> +	}

[Severity: Medium]
Should test_memcg_dmabuf_xfer_at_limit() set ret =3D KSFT_SKIP when
DMA_HEAP_IOCTL_ALLOC fails with EINVAL, ENOTTY or EOPNOTSUPP, matching
test_memcg_dmabuf() and test_memcg_dmabuf_dead_cgroup()?  Without that, the
test fails instead of skipping on kernels without charge_fd support.

> +	close(alloc.charge_fd);
> +	dmabuf_fd =3D (int)alloc.fd;
> +
> +	stat_a =3D cg_read_key_long(cg_a, "memory.stat", "dmabuf ");
> +	if (stat_a =3D=3D -1) {
> +		ret =3D KSFT_SKIP;
> +		goto cleanup_dmabuf;
> +	}
> +	if (stat_a !=3D ONE_MEG)
> +		stat_a =3D cg_read_key_long_poll(cg_a, "memory.stat",
> +					       "dmabuf ", ONE_MEG,
> +					       MEMCG_DMABUF_WAIT_RETRIES,
> +					       DEFAULT_WAIT_INTERVAL_US);
> +	if (stat_a !=3D ONE_MEG) {
> +		fprintf(stderr, "Charge not in A after alloc: expected %d, got %ld\n",
> +			ONE_MEG, stat_a);
> +		goto cleanup_dmabuf;
> +	}
> +
> +	cg_b_fd =3D open(cg_b, O_RDONLY | O_DIRECTORY);
> +	if (cg_b_fd < 0)
> +		goto cleanup_dmabuf;
> +
> +	xfer.charge_fd =3D (__u32)cg_b_fd;
> +	if (ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer) =3D=3D 0) {
> +		fprintf(stderr, "xfer_charge should have failed at limit\n");
> +		goto cleanup_cgfd;
> +	}
> +	if (errno !=3D ENOMEM) {
> +		fprintf(stderr, "Expected ENOMEM, got %s\n", strerror(errno));
> +		goto cleanup_cgfd;
> +	}

[Severity: Low]
Can DMA_BUF_IOCTL_XFER_CHARGE also fail with ENOTTY or EOPNOTSUPP when the
ioctl or memcg accounting is not supported, and should those also set
ret =3D KSFT_SKIP here?

> +
> +	stat_a =3D cg_read_key_long_poll(cg_a, "memory.stat",
> +				       "dmabuf ", ONE_MEG,
> +				       MEMCG_DMABUF_WAIT_RETRIES,
> +				       DEFAULT_WAIT_INTERVAL_US);
> +	if (stat_a !=3D ONE_MEG) {
> +		fprintf(stderr, "Charge leaked from A: expected %d, got %ld\n",
> +			ONE_MEG, stat_a);
> +		goto cleanup_cgfd;
> +	}

[Severity: Medium]
Does polling memory.stat for ONE_MEG leave rstat unflushed on machines with=
 4
or more CPUs?

Reading memory.stat calls __mem_cgroup_flush_stats(memcg, false), which only
flushes rstat when pending updates exceed MEMCG_CHARGE_BATCH *
num_online_cpus() (64 pages per CPU).  ONE_MEG is 256 pages on 4 KB page
systems, so on >=3D 4 CPUs a 1 MB charge or uncharge in test_memcg_dmabuf(),
test_memcg_dmabuf_xfer_at_limit() and test_memcg_dmabuf_dead_cgroup() does
not trigger a synchronous flush and instead waits up to 3 seconds for the
deferrable stats_flush_dwork worker, as described in eb69e955de7b
("selftests: cgroup: make test_memcg_sock check flushed sock stats").

In addition, because stat_a already read ONE_MEG before
DMA_BUF_IOCTL_XFER_CHARGE, cg_read_key_long_poll() here sees the cached
ONE_MEG value on its first iteration and returns immediately without ensuri=
ng
any rstat flush happened after the failed transfer.  Using MEMCG_FLUSH_BYTES
for the buffer size (or forcing a flush before reading) would make the
memory.stat reads cross the flush threshold.

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 1d49df6719198..44e3f33acf877 100644
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
Does pidfd_alloc_supported() return true when memcg is disabled?

When CONFIG_MEMCG=3Dn or cgroup_disable=3Dmemory is passed at boot,
get_obj_cgroup_from_fd() returns ERR_PTR(-EOPNOTSUPP) before inspecting the
fd, whereas an active memcg setup rejects /dev/null with EBADF.  Because
ret < 0 is true on EOPNOTSUPP, pidfd_alloc_supported() reports that charge_=
fd
is supported and the subsequent allocation tests run and fail instead of
skipping.  Checking ret < 0 && errno =3D=3D EBADF avoids this.

[ ... ]

> +static int open_self_cgroupfd(void)
> +{
> +	char cgroup_path[PATH_MAX];
> +	char line[PATH_MAX];
> +	int ret =3D -1;
> +	FILE *f;
> +
> +	f =3D fopen("/proc/self/cgroup", "r");
> +	if (!f)
> +		return -1;
> +	while (fgets(line, sizeof(line), f)) {
> +		if (strncmp(line, "0::", 3))
> +			continue;
> +		line[strcspn(line, "\n")] =3D '\0';
> +		if (snprintf(cgroup_path, sizeof(cgroup_path),
> +			     "/sys/fs/cgroup%s", line + 3) < PATH_MAX)
> +			ret =3D 0;
> +		break;
> +	}
> +	fclose(f);
> +
> +	if (ret)
> +		return -1;
> +
> +	return open(cgroup_path, O_RDONLY | O_DIRECTORY);
> +}

[Severity: Medium]
Can test_alloc_cgroupfd_self() and test_xfer_charge_cgroupfd_self() fail wi=
th
ENOENT when the test process runs in a cgroup without the memory controller
enabled?

Unlike the pidfd path in get_obj_cgroup_from_fd(), which walks up to the
effective ancestor via task_css(), the cgroupfd path calls
css_tryget_online_from_dir(dentry, &memory_cgrp_subsys) directly on the
opened directory and returns -ENOENT when +memory is not enabled in its
parent's cgroup.subtree_control.  Verifying that memory.current (or
memory.stat) exists in cgroup_path, or skipping on ENOENT, would prevent
false failures when dmabuf-heap is run outside vmtest.sh.

> diff --git a/tools/testing/selftests/dmabuf-heaps/vmtest.sh b/tools/testi=
ng/selftests/dmabuf-heaps/vmtest.sh
> new file mode 100755
> index 0000000000000..3574b71ca83e8
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
> @@ -0,0 +1,226 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2026 Red Hat
> +#
> +# Dependencies:
> +#		* virtme-ng
> +#		* qemu	(used by virtme-ng)
> +
> +readonly SCRIPT_DIR=3D"$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" &&=
 pwd -P)"
> +readonly KERNEL_CHECKOUT=3D$(realpath "${SCRIPT_DIR}"/../../../../)
> +readonly CGROUP_DIR=3D"${KERNEL_CHECKOUT}/tools/testing/selftests/cgroup"
> +
> +source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
> +
> +readonly DMABUF_HEAP_TEST=3D"${SCRIPT_DIR}"/dmabuf-heap
> +readonly MEMCONTROL_TEST=3D"${CGROUP_DIR}"/test_memcontrol
> +readonly TMP_DIR=3D$(mktemp -d /tmp/dmabuf-vmtest.XXXXXXXX)

[Severity: Low]
TMP_DIR is created before getopts and before `trap cleanup EXIT` is
registered, so running `vmtest.sh -h` or passing an invalid option exits in
usage() and leaves the temporary directory behind in /tmp.

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

[Severity: Medium]
Does `vmtest.sh -b` exit in check_deps() before building the tests when
DMABUF_HEAP_TEST or MEMCONTROL_TEST has not been built yet?  check_deps() is
called before handle_build(), and only SHELL_MODE returns early before
checking that the test binaries already exist.

[ ... ]

> +	run "dmabuf-heap charge_fd ioctl"	${DMABUF_HEAP_TEST}
> +	run "memcontrol dma-buf memcg"	${MEMCONTROL_TEST} test_memcg_dmabuf
> +	run "memcontrol dma-buf xfer limit" \
> +		${MEMCONTROL_TEST} test_memcg_dmabuf_xfer_at_limit

[Severity: Low]
Should make_runner() also run test_memcg_dmabuf_dead_cgroup here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-v2_2023012=
3_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com?part=3D8

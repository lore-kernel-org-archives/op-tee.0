Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE76606A323
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=3sC+WpJc;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktH/Sfpu
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F145050358
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795611962;
	bh=n94Z5QjDNnxrhpYOf8kO6EMcl6hROGUaihIb0tecnuA=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3sC+WpJcr2DGMEff5Wg24BVf57vqJ9IzZQ85fOx3lKhATjPOZXqn9B/9n6XqEFtKa
	 4x4bmx2JNDD1QSWgrhtFOKbz8jBBrggfb+YQcMhV6+ysnBKsof1pfK/yEtUQEd2vtT
	 sBdkwmsvK3cvmQKv0mgYTw6KTTW7S2qgmzAraioxUor0+j/mcCVltPrX+spSaL5mMq
	 eOGMCdCMMVqYeu1eHbZ4frHlyx+mueEHdAQ72hVZOhgvFmu3xbuviwg6A0jAhqH00N
	 AenRdY9C7WpN7dU/JhE09j672pwCKB5oTR12/0lN2aKr/8Yk0D6a3q5oAQDlDzP+ZM
	 cutCsIziKyHvg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C586A43264
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 13:05:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ktH/Sfpu;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AEF043BCB;
	Wed, 25 Nov 2026 13:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C071F000C0;
	Wed, 25 Nov 2026 13:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795611928;
	bh=yVX4Z3Av7ryf3LrYZitag57whdLEpy0ywu2taML45gM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktH/SfpunRXeT5zhR2dhHk+SUijyNgYhqdbNDA+/vCr1uelXzxHG/fKzVW7++5xli
	 fWf6Rhvy9ACSMIP779/1E8qr4WQ8w4gP+yrpgkFlySmBtoX0zZtbRjpBf+l+AHsZfp
	 okwt56Uy+bQaMXe5mhRcR355F+5I2VD/cjGyWTlB5ACAfJx/LEIx2qBxWsThIlI9P5
	 Hk1U+jfVMg3rtLglt7jY56D43XFWBdlUW/ORxoA6GY/wFSzTuuqdNNKApUTGkW+ijQ
	 7eRaPy/29Q3q3qbWQnQ1cqDPJr6mjeSR8FIrFbJ/XdVB4f6WZyvhYfNqbmm4u4++mq
	 SgSVN16/1gUPA==
Message-ID: <sashiko-outbox-233449@kernel.org>
Subject: Re: [PATCH v6 7/7] selftests/dmabuf-heaps: Add dma-buf memcg
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
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-7-dce12fa03ad6@redhat.com>
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-7-dce12fa03ad6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 13:05:26 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kvack.org,vger.kernel.org,lists.trustedfirmware.org,redhat.com,kernel.org,linuxtv.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C586A43264
X-Spamd-Bar: ------
Message-ID-Hash: AZXQ4ICQLHQ2WR23FMG2VCUVPXSVD5JK
X-Message-ID-Hash: AZXQ4ICQLHQ2WR23FMG2VCUVPXSVD5JK
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: airlied@gmail.com, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AZXQ4ICQLHQ2WR23FMG2VCUVPXSVD5JK/>
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

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [Medium] selftests/cgroup: test_memcg_dmabuf_xfer_at_limit() misses
  skip checks
- [Medium] selftests/cgroup: dmabuf tests read memory.stat below rstat
  flush threshold
- [Medium] selftests/dmabuf-heaps: pidfd_alloc_supported() mishandles
  disabled memcg
- [Medium] selftests/dmabuf-heaps: open_self_cgroupfd() misses memory
  controller check
- [Medium] selftests/dmabuf-heaps: check_deps() runs before
  handle_build() in vmtest.sh
- [Low] selftests/cgroup: child_cg leak on cg_create() error in
  test_memcg_dmabuf()
- [Low] selftests/cgroup: unused MEMCG_SOCKSTAT_WAIT_RETRIES macro in
  test_memcontrol
- [Low] selftests/dmabuf-heaps: make_runner() omits
  test_memcg_dmabuf_dead_cgroup
- [Low] selftests/dmabuf-heaps: vmtest.sh creates TMP_DIR before setting
  EXIT trap
--

commit 65b17f139f560196804a32a9dffe9eb0a344be15
Author: Albert Esteve <aesteve@redhat.com>

selftests/dmabuf-heaps: Add dma-buf memcg accounting tests

This commit adds selftests for dma-buf memcg accounting via charge_fd and
DMA_BUF_IOCTL_XFER_CHARGE in dmabuf-heaps and cgroup/test_memcontrol, along
with a virtme-ng test runner script and config fragment.

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
MEMCG_SOCKSTAT_WAIT_RETRIES was removed by eb69e955de7b ("selftests:
cgroup: make test_memcg_sock check flushed sock stats") and has no users.
Was it re-added here by mistake during a rebase?

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
[ ... ]
> +static int test_memcg_dmabuf(const char *root)
> +{
> +	char *parent =3D NULL, *child_cg =3D NULL;
> +	int ret =3D KSFT_FAIL;
[ ... ]
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
> +	dmabuf_stat =3D cg_read_key_long(child_cg, "memory.stat", "dmabuf ");
> +	if (dmabuf_stat =3D=3D -1) {
> +		ret =3D KSFT_SKIP;
> +		goto cleanup_dmabuf;
> +	}
> +	if (dmabuf_stat !=3D ONE_MEG)
> +		dmabuf_stat =3D cg_read_key_long_poll(child_cg, "memory.stat",
> +						    "dmabuf ", ONE_MEG,
> +						    MEMCG_DMABUF_WAIT_RETRIES,
> +						    DEFAULT_WAIT_INTERVAL_US);

[Severity: Medium]
Can polling memory.stat for ONE_MEG miss the rstat flush threshold in
test_memcg_dmabuf(), test_memcg_dmabuf_xfer_at_limit(), and
test_memcg_dmabuf_dead_cgroup()?

Reading memory.stat only flushes rstat synchronously when pending updates
exceed MEMCG_CHARGE_BATCH * num_online_cpus() pages.  On systems with 4 or
more CPUs (or 64 KB pages), a 1 MB charge or uncharge is below that
threshold, so cg_read_key_long_poll() relies on the periodic 2s deferrable
stats_flush_dwork running within the 3s poll window (the same issue fixed
for test_memcg_sock by eb69e955de7b ("selftests: cgroup: make
test_memcg_sock check flushed sock stats") using MEMCG_FLUSH_BYTES).

In addition, when test_memcg_dmabuf_xfer_at_limit() polls cg_a for ONE_MEG
after DMA_BUF_IOCTL_XFER_CHARGE fails with ENOMEM, cg_read_key_long_poll()
immediately matches the pre-existing cached ONE_MEG value on its first read
without flushing rstat after the ioctl.

[ ... ]
> +static int test_memcg_dmabuf_xfer_at_limit(const char *root)
> +{
[ ... ]
> +	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc) < 0) {
> +		close(alloc.charge_fd);
> +		goto cleanup_heap;
> +	}
> +	close(alloc.charge_fd);
> +	dmabuf_fd =3D (int)alloc.fd;
[ ... ]
> +	xfer.charge_fd =3D (__u32)cg_b_fd;
> +	if (ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer) =3D=3D 0) {
> +		fprintf(stderr, "xfer_charge should have failed at limit\n");
> +		goto cleanup_cgfd;
> +	}
> +	if (errno !=3D ENOMEM) {
> +		fprintf(stderr, "Expected ENOMEM, got %s\n", strerror(errno));
> +		goto cleanup_cgfd;
> +	}

[Severity: Medium]
Should test_memcg_dmabuf_xfer_at_limit() set ret =3D KSFT_SKIP when
DMA_HEAP_IOCTL_ALLOC or DMA_BUF_IOCTL_XFER_CHARGE fails with EINVAL,
ENOTTY, or EOPNOTSUPP?

Unlike test_memcg_dmabuf() and test_memcg_dmabuf_dead_cgroup(), neither
ioctl failure path sets ret =3D KSFT_SKIP, so this test fails instead of
skipping on unpatched kernels or when dma_heap.mem_accounting=3D0.

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 1d49df6719198..44e3f33acf877 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
[ ... ]
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
Does pidfd_alloc_supported() return true when memory cgroups are disabled?

When CONFIG_MEMCG=3Dn or cgroup_disable=3Dmemory is passed at boot,
get_obj_cgroup_from_fd() returns ERR_PTR(-EOPNOTSUPP) before inspecting the
fd.  Because ret < 0 is true, pidfd_alloc_supported() reports charge_fd as
supported (whereas active memcg rejects /dev/null with EBADF), and
test_alloc_pidfd_self(), test_alloc_pidfd_child(), and
test_alloc_cgroupfd_self() then fail with EOPNOTSUPP instead of skipping.

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
What happens in test_alloc_cgroupfd_self() and
test_xfer_charge_cgroupfd_self() if the calling process runs in a cgroup
where the memory controller is not enabled?

Unlike the pidfd path in get_obj_cgroup_from_fd(), which resolves the
effective ancestor CSS via task_css(), the cgroup directory fd path calls
css_tryget_online_from_dir() directly on that directory and fails with
ENOENT when +memory is not enabled in its parent's cgroup.subtree_control,
causing both tests to fail instead of skipping.

> diff --git a/tools/testing/selftests/dmabuf-heaps/vmtest.sh b/tools/testi=
ng/selftests/dmabuf-heaps/vmtest.sh
> new file mode 100755
> index 0000000000000..3574b71ca83e8
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
> @@ -0,0 +1,226 @@
[ ... ]
> +readonly DMABUF_HEAP_TEST=3D"${SCRIPT_DIR}"/dmabuf-heap
> +readonly MEMCONTROL_TEST=3D"${CGROUP_DIR}"/test_memcontrol
> +readonly TMP_DIR=3D$(mktemp -d /tmp/dmabuf-vmtest.XXXXXXXX)

[Severity: Low]
Does creating TMP_DIR before getopts leak /tmp/dmabuf-vmtest.XXXXXXXX when
usage() exits on -h or an invalid option before trap cleanup EXIT is
installed?

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
Does check_deps() exit with KSFT_SKIP when vmtest.sh -b is run on an
unbuilt tree?

check_deps() runs before handle_build() compiles DMABUF_HEAP_TEST and
MEMCONTROL_TEST, and it only returns early for SHELL_MODE, not BUILD.

[ ... ]
> +	run "dmabuf-heap charge_fd ioctl"	${DMABUF_HEAP_TEST}
> +	run "memcontrol dma-buf memcg"	${MEMCONTROL_TEST} test_memcg_dmabuf
> +	run "memcontrol dma-buf xfer limit" \
> +		${MEMCONTROL_TEST} test_memcg_dmabuf_xfer_at_limit

[Severity: Low]
Should make_runner() also run test_memcg_dmabuf_dead_cgroup here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_2023012=
3_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com?part=3D7

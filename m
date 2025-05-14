From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4 05/11] firmware: qcom: scm: add support for object invocation
Date: Wed, 14 May 2025 17:27:44 +0200
Message-ID: 
 <CACMJSev2qqnxLN6OiSEKhUqxeewY09to0Jd2oPNoE39YFS6i3A@mail.gmail.com>
In-Reply-To: <aCRkRTMFi65zBODh@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4995020326311568452=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4995020326311568452==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 at 11:37, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> Hi Amir,
>
> I am still unable to get the QCOMTEE driver to work on db845c. As I can
> see machine: "qcom,sdm845" is not supported for tzmem based on SHM
> brigde here: drivers/firmware/qcom/qcom_tzmem.c +81. I am still seeing
> following logs from userspace:
>
> # /mnt/unittest -d
> [test_print_diagnostics_info][31] test_get_client_env_object.
> [test_supplicant_release][65] test_supplicant_worker killed.
>
> I think you should first check here for SHM bridge support. If available
> then only add a QTEE platform device.
>

On platforms not supporting SHM Bridge, the module should fall back to
non-SHM mode. Isn't it the case?

Bart

--===============4995020326311568452==--


From: Krzysztof Kozlowski <krzk@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 3/4] dt-bindings: remoteproc: add compatibility for
 TEE support
Date: Tue, 30 May 2023 13:50:48 +0200
Message-ID: <1b4eba7e-2771-b0c8-ec23-2ed882374e5d@kernel.org>
In-Reply-To: <20230523091350.292221-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5070198561427291679=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5070198561427291679==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 23/05/2023 11:13, Arnaud Pouliquen wrote:
> Rework compatibility description according to the support of
> the authenticated firmware relying on OP-TEE authentication.
> 
> The expected behavior is:
> - with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
>   non-signed (ELF) firmware image,
> - with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
>   firmware image. In this case it calls TEE services to manage the firmware
>   loading and the remoteproc life-cycle.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend and include all necessary entries.

Because of above and RFC, I assume there is no need for review. Just to
be clear - that's a no.

Best regards,
Krzysztof


--===============5070198561427291679==--


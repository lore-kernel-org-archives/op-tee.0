From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v5 4/4] firmware: arm_scmi: optee: use optee system invocation
Date: Wed, 22 Mar 2023 16:40:07 +0000
Message-ID: <20230322164007.hjsjifg4wznxkgdz@bogus>
In-Reply-To: <20230320162801.2811542-4-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4543020157894909135=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4543020157894909135==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Mar 20, 2023 at 05:28:01PM +0100, Etienne Carriere wrote:
> Changes SCMI optee transport to call tee_client_system_session()
> to request optee driver to provision an entry context in OP-TEE
> for processing OP-TEE messages. This prevents possible deadlock
> in case OP-TEE threads are all consumed while these may be waiting
> for a clock or regulator to be enable which SCMI OP-TEE service which
> requires a free thread context to execute.
>

Assuming it will be routed via OPTEE tree,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

--===============4543020157894909135==--


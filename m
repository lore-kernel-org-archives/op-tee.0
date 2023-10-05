From: "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3] virtio-tee: Reserve device ID 46 for TEE device
Date: Thu, 05 Oct 2023 10:40:16 +0530
Message-ID: <5cf1f33c-73b2-4377-bd5f-242cc18d5762@amd.com>
In-Reply-To: <=?utf-8?q?=3Ccf8eee37bb9f5c2408f0ed8f4798e87b3c01f39c=2E1695881?=
 =?utf-8?q?523=2Egit=2EJESHWANTHKUMAR=2ENK=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7099371203461451993=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7099371203461451993==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/175

Request for votes.

Regards,

Jeshwanth

On 28-Sep-23 11:42 AM, jeshwank wrote:
> In a virtual environment, an application running in guest VM may want
> to delegate security sensitive tasks to a Trusted Application (TA)
> running within a Trusted Execution Environment (TEE). A TEE is a trusted
> OS running in some secure environment, for example, TrustZone on ARM
> CPUs, or a separate secure co-processor etc.
>
> A virtual TEE device emulates a TEE within a guest VM. Such a virtual
> TEE device supports multiple operations such as:
>
> VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
>                               TEE device.
> VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
>                                TEE device.
> VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
> VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
>                                trusted application running in TEE.
> VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
>                                 with trusted application running in TEE.
> VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
>                               application running in TEE.
> VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
> VIRTIO_TEE_CMD_REGISTER_MEM - Register shared memory with TEE.
> VIRTIO_TEE_CMD_UNREGISTER_MEM - Unregister shared memory from TEE.
>
> We would like to reserve device ID 46 for Virtio-TEE device.
>
> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   content.tex | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 0a62dce..644aa4a 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
>   \hline
>   45         &   SPI master \\
>   \hline
> +46         &   TEE device \\
> +\hline
>   \end{tabular}
>   
>   Some of the devices above are unspecified by this document,

--===============7099371203461451993==--


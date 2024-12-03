From: Trilok Soni <quic_tsoni@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 00/10] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Mon, 02 Dec 2024 22:06:26 -0800
Message-ID: <518ee3f1-b871-4349-ba85-3b3fc835a4ca@quicinc.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?0-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7766309408885222510=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7766309408885222510==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/2/2024 8:19 PM, Amirreza Zarrabi wrote:
> This patch series introduces a Trusted Execution Environment (TEE)
> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> and services to run securely. It uses an object-based interface, where
> each service is an object with sets of operations. Clients can invoke
> these operations on objects, which can generate results, including other
> objects. For example, an object can load a TA and return another object
> that represents the loaded TA, allowing access to its services.

The first patch series was RFC and now you had removed the RFC. Can you please
provide the reasons?

https://lwn.net/ml/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee(=
a)quicinc.com/

I understand that you have now changed to tee framework but I want to check
if we should continue with the version and increment here or start from [00]?

--=20
---Trilok Soni

--===============7766309408885222510==--


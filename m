From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: optee: add interrupt controller
 properties
Date: Tue, 16 May 2023 10:03:46 +0200
Message-ID: <4529262a-59c2-1610-2d7f-d2e3529bf867@linaro.org>
In-Reply-To: <
 <CAN5uoS-U1h_Fx1K4PtnK3vHmyfUUS6wqCcSfhoaV=idgEOC04Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8612084837825536790=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8612084837825536790==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 16/05/2023 08:02, Etienne Carriere wrote:
> Dear all,
> 
> On Sat, 6 May 2023 at 09:33, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
>>
>> Adds an optional interrupt controller property to optee firmware node
>> in the DT bindings. Optee driver may embeds an irqchip exposing
>> OP-TEE interrupt events notified by the TEE world. Optee registers up
>> to 1 interrupt controller and identifies each line with a line
>> number from 0 to UINT16_MAX.
>>
>> The identifiers and meaning of the interrupt line number are specific
>> to the platform and shall be found in the OP-TEE platform documentation.
>>
>> In the example shown in optee DT binding documentation, the platform SCMI
>> device controlled by Linux scmi driver uses optee interrupt irq 5 as
>> signal to trigger processing of an asynchronous incoming SCMI message
>> in the scope of a CPU DVFS control. A platform can have several SCMI
>> channels driven this way. Optee irqs also permit small embedded devices
>> to share e.g. a gpio expander, a group of wakeup sources, etc... between
>> OP-TEE world (for sensitive services) and Linux world (for non-sensitive
>> services). The physical controller is driven from the TEE which exposes
>> some controls to Linux kernel.
>>
>> Cc: Jens Wiklander <jens.wiklander@linaro.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
>> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
>> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
>> ---
> 
> Any feedback on this change proposal?

Rob had here several comments, so I will defer it to him.

I don't get why this is not part of linaro,scmi-optee driver directly. I
think it's the only valid use case because the others like GPIO
expanders seem  a stretch.


Best regards,
Krzysztof


--===============8612084837825536790==--


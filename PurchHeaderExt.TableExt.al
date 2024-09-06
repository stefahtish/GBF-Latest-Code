tableextension 50124 PurchHeaderExt extends "Purchase Header"
{
    fields
    {
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            var
                UserSetUp: record "User Setup";
            begin
            end;
        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                PurchSetup.Get;
                PurchSetup.TestField("Order Due Days");
                "Due Date" := CalcDate(PurchSetup."Order Due Days", "Order Date");
                Modify();
            end;
        }
        // modify("Buy-from Vendor No.")
        // {
        //     TableRelation = Vendor where("Vendor Type" = const(Vendor));
        //     trigger OnAfterValidate()
        //     begin
        //         GLSetup.get;
        //         GLSetup.TestField("Allow Posting From");
        //         GLSetup.TestField("Allow Posting To");
        //         if ("Posting Date" < GLSetup."Allow Posting From") then
        //             Error('Posting date should be within allowed ranges in GL setup');
        //         if ("Posting Date" > GLSetup."Allow Posting To") then
        //             Error('Posting date should be within allowed ranges in GL setup');
        //         if UserSetUp.get(UserId) then begin
        //             if UserSetUp."Allow Posting From" <> 0D then begin
        //                 if ("Posting Date" > UserSetUp."Allow Posting To") then
        //                     Error('Posting date should be within your allowed ranges in User setup');
        //             end;
        //             if UserSetUp."Allow Posting To" <> 0D then begin
        //                 if ("Posting Date" > UserSetUp."Allow Posting To") then
        //                     Error('Posting date should be within your allowed ranges in User setup');
        //             end;
        //         end;
        //     end;
        // }
        field(50000; "Date-Time Posted"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Archived; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54000; Justification; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54001; "Tender/Quotation ref no"; Code[30])
        {
            Caption = 'Ref No.';
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request"; //where("Process Type" = const(Tender));
        }
        field(54002; Minutes; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54003; "LPO Category"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category"."Category Code" WHERE(Type = FILTER(LPO));
        }
        field(54005; "Fully Ordered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54008; Uncommitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54009; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54010; "Procurement Plan"; Code[15])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan";
        }
        field(54011; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(54012; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Employee No.") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;
        }
        field(54013; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(54014; "LPO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Consumables,Cost of Sales,Fixed Asset';
            OptionMembers = Consumables,"Cost of Sales","Fixed Asset";
        }
        field(54015; "SRN Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Consumables,Cost of Sales,Fixed Asset';
            OptionMembers = Consumables,"Cost of Sales","Fixed Asset";
        }
        field(54016; "RFQ No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Internal Request Header"."No." WHERE("Document Type" = FILTER(RFQ));

            trigger OnValidate()
            var
                IR: Record "Internal Request Header";
                IRLine: Record "Internal Request Line";
            begin
                if "RFQ No." <> '' then begin
                    if Confirm('Are you sure you want to use this RFQ Document', false) = true then begin
                        IR.Reset;
                        IR.SetRange("No.", "RFQ No.");
                        if IR.Find('-') then begin
                            IRLine.Reset;
                            IRLine.SetRange("Document No.", IR."No.");
                            //IRLine.SETFILTER("Qty. to Receive",'>%1',0);
                            if IRLine.Find('-') then begin
                                PurchSetup.Get;
                                "Document Date" := Today;
                                "Requisition No." := IR."Requisition No.";
                                "Assigned User ID" := UserId;
                                Commit;
                                repeat //insert lines
                                    PurchLine.Init;

                                    PurchLine.TransferFields(IRLine);
                                    PurchLine."Document Type" := "Document Type";
                                    PurchLine."Document No." := "No.";
                                    PurchLine.Validate("No.");

                                    PurchLine."Buy-from Vendor No." := "Buy-from Vendor No.";
                                    PurchLine."Pay-to Vendor No." := "Buy-from Vendor No.";
                                    PurchLine.Validate("Buy-from Vendor No.", "Pay-to Vendor No.");
                                    PurchLine."Quantity Received" := 0;
                                    PurchLine.Validate(Quantity, IRLine."Qty. to Receive");
                                    //MESSAGE(IRLine."Requisition No.");
                                    PurchLine."Requisition No." := IRLine."Requisition No.";
                                    PurchLine."Unit of Measure" := IRLine."Unit of Measure";
                                    PurchLine."Unit of Measure Code" := IRLine."Unit of Measure";
                                    PurchLine.Description := IRLine.Description;
                                    PurchLine.Specification2 := IRLine.Specification2;
                                    PurchLine.Type := IRLine.Type2;
                                    PurchLine."No." := IRLine."Charge to No.";
                                    PurchLine.Insert;
                                    IRLine."Quantity Received" := IRLine."Quantity Received" + IRLine."Qty. to Receive";
                                    IRLine."Qty. to Receive" := IRLine.Quantity - IRLine."Quantity Received";
                                //IRLine.MODIFY;
                                until IRLine.Next = 0;
                            end;
                        end;
                    end
                    else
                        exit;
                    /*END ELSE IF "Combine Order"=FALSE THEN
                          BEGIN
                            DocNo:=NoseriesMgt.GetNextNo(PurchSetup."Quote Nos.",0D,TRUE);
                            PurchHeader.INIT;
                            PurchHeader.TRANSFERFIELDS(IR);
                            PurchHeader.VALIDATE("No.");
                            PurchHeader."No.":=DocNo;
                            PurchHeader."Document Type":=PurchHeader."Document Type"::Quote;
                            PurchHeader.Status:=PurchHeader.Status::Open;
                            //PurchHeader."Buy-from Vendor No.":=IRLine.Supplier;
                            //PurchHeader.VALIDATE("Buy-from Vendor No.");
                            PurchHeader."Document Date":=TODAY;
                            PurchHeader."Requisition No.":="No.";
                            PurchHeader.INSERT;
                          PurchSetup.GET;
                          //insert lines
                          PurchLine.INIT;
                          PurchLine.TRANSFERFIELDS(IRLine);
                          PurchLine.VALIDATE(Type);
                          PurchLine.VALIDATE("No.");
                          PurchLine."Document No.":=DocNo;
                          PurchLine."Document Type":=PurchLine."Document Type"::Quote;
                          PurchLine."Quantity Received":=0;
                          PurchLine.VALIDATE(Quantity,IRLine."Qty. to Receive");
                          PurchLine."Requisition No.":="No.";
                    //      PurchLine."Gen. Bus. Posting Group":='GENERAL';
                    //      PurchLine."Gen. Prod. Posting Group":='GENERAL';
                    //      PurchLine."VAT Bus. Posting Group":="VAT Bus. Posting Group";
                          PurchLine.INSERT;
                    //      Committement.UncommitPurchReq(IRLine,IR);
                    //      Committement.EncumberPO(PurchLine,PurchHeader);
                          IRLine."Quantity Received":=IRLine."Quantity Received"+IRLine."Qty. to Receive";
                          IRLine."Qty. to Receive":=IRLine.Quantity-IRLine."Quantity Received";
                          //IRLine.MODIFY;
                          MESSAGE('Quote No %1 has been created',DocNo);
                          END;
                        END;
                    //    IF CheckifFullyordered(IR)=TRUE THEN
                    //      IR."Fully Ordered":=TRUE;
                    //      IR.MODIFY;*/
                end;
            end;
        }
        field(54017; Replenishment; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                TestField("Shortcut Dimension 1 Code");
                TestField("Shortcut Dimension 2 Code");
            end;
        }
        field(54018; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54019; Reference; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54020; "Old LPO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54021; "Max Date"; Date)
        {
            CalcFormula = Max("Purchase Line"."Expected Receipt Date" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(54022; "Cancel Comments"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54023; "Cancelled By"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(54024; "Order No Custom"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(54025; "LPO Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54026; "Close Comments"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54027; "Closed By"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(54028; "Reason Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54029; Apportion; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54030; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(54031; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Ammend;
            ObsoleteState = Removed;
        }
        field(54032; "Ammend Order No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header" where("Document Type" = const(Order));
            ObsoleteState = Removed;
        }
        field(54033; "Sent for Inspection"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54034; Acknowledged; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54500; "OrderType"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Ammend;
        }
        field(54501; "Ammend Order No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header" where("Document Type" = const(Order));
        }
        field(54502; "Procurement Method"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(54503; "Vendor Pin No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54504; "Delivery No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54505; "Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(54506; "GRN Nos"; Code[50])
        {
        }
        field(54507; "No. Series1"; Code[50])
        {
            Caption = 'No.Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    trigger OnAfterInsert()
    begin
        "User ID" := UserId;
        validate("Document Date");
    end;

    trigger OnInsert()
    begin
        PurchasePayable.Get();
        PurchasePayable.TestField("GRN Nos");
        if Rec."GRN Nos" = '' then begin
            Noseries.InitSeries(PurchasePayable."GRN Nos", xRec."No. Series1", 0D, "GRN Nos", "No. Series1");
        end;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        PurchLine: Record "Purchase Line";
        Employee: Record Employee;
        UserSetUp: record "User Setup";
        PurchasePayable: Record "Purchases & Payables Setup";
        Noseries: Codeunit NoSeriesManagement;
}

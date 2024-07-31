tableextension 50131 PurchRcptHeaderExt extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50000; "Date-Time Posted"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Requisition No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(54000; Justification; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(54001; "Tender/Quotation ref no"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54002; Minutes; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54003; "LPO Category"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category"."Category Code" WHERE(Type=FILTER(LPO));
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
        }
        field(54013; "Employee Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(54014; "LPO Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Consumables,Cost of Sales,Fixed Asset';
            OptionMembers = Consumables, "Cost of Sales", "Fixed Asset";
        }
        field(54015; "SRN Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Consumables,Cost of Sales,Fixed Asset';
            OptionMembers = Consumables, "Cost of Sales", "Fixed Asset";
        }
        field(54016; "RFQ No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Internal Request Header"."No." WHERE("Document Type"=FILTER(RFQ));

            trigger OnValidate()
            var
                IR: Record "Internal Request Header";
                IRLine: Record "Internal Request Line";
            begin
            /*IF CONFIRM('Are you sure you want to use this RFQ Document',FALSE)=TRUE THEN
                  BEGIN
                    IR.RESET;
                    IR.SETRANGE("No.","RFQ No.");
                    IF IR.FIND('-') THEN
                    BEGIN
                      IRLine.RESET;
                      IRLine.SETRANGE("Document No.",IR."No.");
                      //IRLine.SETFILTER("Qty. to Receive",'>%1',0);
                      IF IRLine.FIND('-') THEN
                        BEGIN
                        PurchSetup.GET;
                        "Document Date":=TODAY;
                        "Requisition No.":=IR."Requisition No.";
                        "Assigned User ID":=USERID;
                        COMMIT;
                          REPEAT
                          //insert lines
                          PurchLine.INIT;
                          PurchLine.TRANSFERFIELDS(IRLine);
                          PurchLine."Document Type":="Document Type";
                            PurchLine."Document No.":="No.";
                          //PurchLine.VALIDATE("No.");
                          PurchLine."Buy-from Vendor No.":="Buy-from Vendor No.";
                          PurchLine."Pay-to Vendor No.":="Buy-from Vendor No.";
                          PurchLine.VALIDATE("Buy-from Vendor No.","Pay-to Vendor No.");
                          PurchLine."Quantity Received":=0;
                          PurchLine.VALIDATE(Quantity,IRLine."Qty. to Receive");
                          //MESSAGE(IRLine."Requisition No.");
                          PurchLine."Requisition No.":=IRLine."Requisition No.";
                          PurchLine."Unit of Measure":=IRLine."Unit of Measure";
                          PurchLine.Specifications:=IRLine.Specifications;
                          PurchLine.INSERT;
                
                          IRLine."Quantity Received":=IRLine."Quantity Received"+IRLine."Qty. to Receive";
                          IRLine."Qty. to Receive":=IRLine.Quantity-IRLine."Quantity Received";
                          //IRLine.MODIFY;
                          UNTIL IRLine.NEXT=0;
                        END;
                    END;
                  END ELSE
                    EXIT;
                
                    {END ELSE IF "Combine Order"=FALSE THEN
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
                //      IR.MODIFY;}
                */
            end;
        }
        field(54017; Replenishment; Boolean)
        {
            DataClassification = ToBeClassified;
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
        field(54029; Apportion; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54030; "Vendor Invoice No."; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(54031; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54032; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
}

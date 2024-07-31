codeunit 50146 ProjectManagement
{
    procedure CreateSalesInvoice(ProjectNo: Code[100])
    var
        LineNo: Integer;
        Project1: Record ProjectIdentification;
        SalesHeader: Record "Sales Header";
        InternalReq: Record "Internal Request Line";
        SalesLine: Record "Sales Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        NoseriesMgt: Codeunit NoSeriesManagement;
        ProjectLines: Record "Project Tasks Mgmt";
        GLSetup: Record "General Ledger Setup";
        CashSetup: Record "Cash Management Setups";
        Project: Record ProjectIdentification;
        SalesSetup: Record "Sales & Receivables Setup";
        CustomerRec: Record Customer;
        VATProdGrp: Code[20];
        VATBusGrp: Code[20];
    begin
        Clear(VATBusGrp);
        Clear(VATProdGrp);
        Project.Reset();
        Project.SetRange("Project No.", ProjectNo);
        If Project.FindFirst()then begin
            GLSetup.Get();
            CashSetup.Get();
            SalesSetup.Get();
            //REPEAT
            DocNo:=NoseriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);
            SalesHeader.Init;
            SalesHeader."No.":=DocNo;
            SalesHeader.Validate("No.");
            SalesHeader."Document Type":=SalesHeader."Document Type"::Invoice;
            SalesHeader.Status:=SalesHeader.Status::Open;
            SalesHeader."Sell-to Customer No.":=Project."Client Code";
            SalesHeader.Validate("Sell-to Customer No.");
            SalesHeader."Bill-to Customer No.":=Project."Client Code";
            SalesHeader.Validate("Bill-to Customer No.");
            CustomerRec.Reset();
            CustomerRec.SetRange("No.", Project."Client Code");
            if CustomerRec.FindFirst()then SalesHeader."Gen. Bus. Posting Group":=CustomerRec."Gen. Bus. Posting Group";
            SalesHeader."Document Date":=Today;
            SalesHeader."Posting Date":=Today;
            SalesHeader."Order Date":=Today;
            SalesHeader."Project Code":=ProjectNo;
            SalesHeader."Due Date":=Project."Date Created";
            SalesHeader."Assigned User ID":=UserId;
            SalesHeader."Document Date":=Project."Date Created";
            //SalesHeader."Shortcut Dimension 1 Code" := GlSetup."Shortcut Dimension 1 Code";
            SalesHeader.Insert;
            //insert milestone
            //ProjectLines.Reset();
            //ProjectLines.SetRange("Project No.", Project."Project No.");
            // ProjectLines.SetRange("Milestone Closed", true);
            // ProjectLines.SetRange("Sales Invoice Generated", false);
            // If ProjectLines.FindSet() then begin
            // repeat
            //insert lines
            LineNo:=LineNo + 1000;
            SalesLine.Init;
            SalesLine."Document No.":=DocNo;
            SalesLine."Line No.":=LineNo;
            SalesLine."Document Type":=SalesLine."Document Type"::Invoice;
            SalesLine.Type:=SalesLine.Type::"G/L Account";
            SalesLine.Validate(Type);
            SalesLine."No.":=Project."Project Account";
            SalesLine.Validate("No.");
            SalesLine."Unit of Measure":=Project."Unit of Measure";
            SalesLine."Quantity":=1;
            //SalesLine."Currency Code":= Project.curr
            //SalesLine."VAT Prod. Posting Group" := PurchSetup."Def VAT Prod. Posting Group";
            //SalesLine."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
            SalesLine.Validate("VAT Prod. Posting Group");
            SalesLine."Unit Price":=Project."Project Budget";
            SalesLine.Validate("Unit Price");
            SalesLine."Shortcut Dimension 1 Code":=GlSetup."Shortcut Dimension 1 Code";
            SalesLine."Project Code":=Project."Project Code";
            SalesLine.Description:=Project."Project Name";
            SalesLine.Insert;
        // Committement.UncommitPurchReqOnQuote("Quote No", "Requisition No");
        //Committement.EncumberSinv(SalesLine, SalesHeader);
        // Project1.Modify;
        //ProjectLines."Sales Invoice Generated" := true;
        // ProjectLines.Modify();
        //until ProjectLines.Next() = 0;
        // end;
        end;
        Message('Sales invoice No %1 has been successfully created', DocNo);
    end;
    procedure CreateInvoicePerMilestone(ProjectNo: Code[100])
    var
        LineNo: Integer;
        Project1: Record ProjectIdentification;
        SalesHeader: Record "Sales Header";
        InternalReq: Record "Internal Request Line";
        SalesLine: Record "Sales Line";
        DocNo: Code[20];
        Committement: Codeunit Committment;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        NoseriesMgt: Codeunit NoSeriesManagement;
        ProjectLines: Record "Project Tasks Mgmt";
        GLSetup: Record "General Ledger Setup";
        CashSetup: Record "Cash Management Setups";
        ProjectHeader: Record ProjectIdentification;
        Project: Record PMWorkPlan;
        SalesSetup: Record "Sales & Receivables Setup";
        CustomerRec: Record Customer;
        VATProdGrp: Code[20];
        VATBusGrp: Code[20];
    begin
        Clear(VATBusGrp);
        Clear(VATProdGrp);
        ProjectHeader.Reset();
        ProjectHeader.SetRange("Project No.", ProjectNo);
        if ProjectHeader.FindFirst()then;
        Project.SetCurrentKey(WPNO1, "Project No.");
        Project.Reset();
        Project.SetRange("Project No.", ProjectNo);
        Project.SetRange("Invoice Created", false);
        If Project.FindFirst()then begin
            GLSetup.Get();
            CashSetup.Get();
            SalesSetup.Get();
            //REPEAT
            DocNo:=NoseriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, true);
            SalesHeader.Init;
            SalesHeader."No.":=DocNo;
            SalesHeader.Validate("No.");
            SalesHeader."Document Type":=SalesHeader."Document Type"::Invoice;
            SalesHeader.Status:=SalesHeader.Status::Open;
            SalesHeader."Sell-to Customer No.":=ProjectHeader."Client Code";
            SalesHeader.Validate("Sell-to Customer No.");
            SalesHeader."Bill-to Customer No.":=ProjectHeader."Client Code";
            SalesHeader.Validate("Bill-to Customer No.");
            CustomerRec.Reset();
            CustomerRec.SetRange("No.", ProjectHeader."Client Code");
            if CustomerRec.FindFirst()then SalesHeader."Gen. Bus. Posting Group":=CustomerRec."Gen. Bus. Posting Group";
            SalesHeader."Document Date":=Today;
            SalesHeader."Posting Date":=Today;
            SalesHeader."Order Date":=Today;
            SalesHeader."Project Code":=ProjectNo;
            SalesHeader."Due Date":=ProjectHeader."Date Created";
            SalesHeader."Assigned User ID":=UserId;
            SalesHeader."Document Date":=ProjectHeader."Date Created";
            //SalesHeader."Shortcut Dimension 1 Code" := GlSetup."Shortcut Dimension 1 Code";
            SalesHeader.Insert;
            LineNo:=LineNo + 1000;
            SalesLine.Init;
            SalesLine."Document No.":=DocNo;
            SalesLine."Line No.":=LineNo;
            SalesLine."Document Type":=SalesLine."Document Type"::Invoice;
            SalesLine.Type:=SalesLine.Type::"G/L Account";
            SalesLine.Validate(Type);
            SalesLine."No.":=ProjectHeader."Project Account";
            SalesLine.Validate("No.");
            SalesLine."Unit of Measure":=ProjectHeader."Unit of Measure";
            SalesLine."Quantity":=1;
            //SalesLine."Currency Code":= Project.curr
            //SalesLine."VAT Prod. Posting Group" := PurchSetup."Def VAT Prod. Posting Group";
            //SalesLine."VAT Bus. Posting Group" := PurchSetup."Def VAT Bus. Posting Group";
            SalesLine.Validate("VAT Prod. Posting Group");
            SalesLine."Unit Price":=Project.Amount;
            SalesLine.Validate("Unit Price");
            SalesLine."Shortcut Dimension 1 Code":=GlSetup."Shortcut Dimension 1 Code";
            SalesLine."Project Code":=ProjectNo;
            SalesLine.Description:=Project.Deliverable;
            SalesLine.Phase:=Project.Phase;
            SalesLine.Insert;
            // Committement.UncommitPurchReqOnQuote("Quote No", "Requisition No");
            //Committement.EncumberSinv(SalesLine, SalesHeader);
            // Project1.Modify;
            //ProjectLines."Sales Invoice Generated" := true;
            // ProjectLines.Modify();
            //until ProjectLines.Next() = 0;
            // end;
            Project."Invoice Created":=true;
            Project.Modify();
        end
        else
            Error('There are no billable milestones');
        Message('Sales invoice No %1 has been successfully created', DocNo);
    end;
    procedure CreateTestParameterEntries(InterviewRec: Record "Interview Committe")
    var
        InterviewStage: Record "Interview Stage";
        InterviewStage2: Record "Interview Stage";
        LineNoIS: Integer;
        JobApplied: Record "Applicant job applied";
        NewLinesNoIS: Integer;
        TestParRec: Record "Test Parameters";
        InterviewPanel: Record "Interview Panel Members";
        InterviewSetupEnt: Record "Interview Setup Entries";
        InterviewEntries: Record "Interview Entries";
    begin
        if InterviewStage.FindLast()then LineNoIS:=InterviewStage."Line No.";
        JobApplied.Reset();
        JobApplied.SetRange(Qualified, true);
        JobApplied.SetRange("Need Code", InterviewRec."Job ID");
        if JobApplied.FindSet()then repeat if TestParRec.FindSet()then repeat InterviewPanel.Reset();
                        InterviewPanel.SetRange("Panel Member Code", InterviewRec."No.");
                        if InterviewPanel.FindSet()then repeat LineNoIS:=LineNoIS + 1;
                                InterviewStage2.Reset();
                                InterviewStage2."Applicant No":=JobApplied."Application No.";
                                InterviewStage2."Test Parameter":=TestParRec.Code;
                                InterviewStage2.Description:=TestParRec.Description;
                                InterviewStage2."Line No.":=LineNoIS;
                                InterviewStage2."Interviewer Code":=InterviewPanel."Panel Member Code";
                                InterviewStage2."Interviwer Name":=InterviewPanel."Panel Member Name";
                                InterviewStage2."Pass Mark":=TestParRec."Pass Mark";
                                InterviewStage2."Maximum Marks":=TestParRec."Max Marks";
                                InterviewStage2."Job ID":=InterviewRec."Job ID";
                                InterviewStage2.Insert();
                            until InterviewPanel.Next() = 0;
                    until TestParRec.Next() = 0;
            until JobApplied.Next() = 0;
    end;
    procedure CreateInterviewEntries(InterviewRec: Record "Interview Committe")
    var
        InterviewEntries: Record "Interview Entries";
        InterviewEntries2: Record "Interview Entries";
        JobApplied: Record "Applicant job applied";
        LineNoInt: Integer;
        InterviewSetupEnt: Record "Interview Setup Entries";
        IntPanel: Record "Interview Panel Members";
    begin
        if InterviewEntries2.FindLast()then LineNoInt:=InterviewEntries2."Line No.";
        JobApplied.Reset();
        JobApplied.SetRange(Qualified, true);
        JobApplied.SetRange("Need Code", InterviewRec."Job ID");
        if JobApplied.FindSet()then repeat IntPanel.Reset();
                IntPanel.SetRange("Panel Member Code", InterviewRec."No.");
                if IntPanel.FindSet()then repeat InterviewSetupEnt.Reset();
                        InterviewSetupEnt.SetRange("No.", InterviewRec."No.");
                        if InterviewSetupEnt.FindSet()then repeat LineNoInt:=LineNoInt + 1;
                                InterviewEntries.Init();
                                InterviewEntries."Line No.":=LineNoInt;
                                InterviewEntries."Application No.":=JobApplied."Application No.";
                                InterviewEntries.Description:=InterviewSetupEnt.Description;
                                InterviewEntries.Type:=InterviewSetupEnt.Type;
                                InterviewEntries."Classroom Interview":=InterviewSetupEnt."Classroom Interview";
                                InterviewEntries."Oral Interview":=InterviewSetupEnt."Oral Interview";
                                InterviewEntries."Oral Interview (Board)":=InterviewSetupEnt."Oral Interview (Board)";
                                InterviewEntries."Need Code":=InterviewRec."Job ID";
                                InterviewEntries.Practical:=InterviewSetupEnt.Practical;
                                InterviewEntries."Pass Mark":=InterviewSetupEnt."Pass Mark";
                                InterviewEntries."Interviewer Name":=IntPanel."Panel Member Name";
                                InterviewEntries.Insert();
                            until InterviewSetupEnt.Next() = 0;
                    until IntPanel.Next() = 0;
            until JobApplied.Next() = 0;
    end;
}

page 50574 "Training Needs"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Training';
    SourceTable = "Training Need";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Training Objectives"; Rec."Training Objectives")
                {
                    MultiLine = true;
                }
                field("Provider Name"; Rec."Provider Name")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Open/Closed"; Rec."Open/Closed")
                {
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    Visible = false;
                }
                field(Duration; Rec.Duration)
                {
                    Visible = false;
                }
                field("Country Code"; Rec."Country Code")
                {
                    Visible = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    Editable = false;
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                    Editable = false;
                }
                field(Location; Rec.Location)
                {
                    Visible = true;
                }
                field(Venue; Rec.Venue)
                {
                    Visible = false;
                }
                group(More)
                {
                    Caption = 'More Details';

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Visible = false;
                    }
                    field(DimVal1; Rec.DimVal1)
                    {
                        Caption = 'Name';
                        Visible = false;
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Visible = false;
                    }
                    field(DimVal2; Rec.DimVal2)
                    {
                        Caption = '&Name';
                        Visible = false;
                    }
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                    }
                    field("No. of Participants"; Rec."No. of Participants")
                    {
                    }
                    field("Need Source"; Rec."Need Source")
                    {
                    }
                    field("Total Cost"; Rec."Total Cost")
                    {
                        Visible = false;
                    }
                    field("Total PerDiem"; Rec."Total PerDiem")
                    {
                        Visible = false;
                    }
                }
                group(Control23)
                {
                    ShowCaption = false;
                    Visible = false;

                    field(Qualification; Rec.Qualification)
                    {
                    }
                    field("Re-Assessment Date"; Rec."Re-Assessment Date")
                    {
                    }
                    field(Source; Rec.Source)
                    {
                    }
                    field(Post; Rec.Post)
                    {
                    }
                    field(Posted; Rec.Posted)
                    {
                    }
                    field("Department Code"; Rec."Department Code")
                    {
                    }
                }
            }
            part(Control39; "Training Needs Lines")
            {
                //Visible = true;
                SubPageLink = "Document No." = FIELD(Code);
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Ready)
            {
                Caption = 'Set As Ready For Application';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to set this need as ready for application ?', false) then begin
                        //   Committment.TrainingNeedCommittment(Rec,ErrorMsg);
                        //    IF ErrorMsg<>'' THEN
                        //      ERROR(ErrorMsg);
                        Rec.Status := Rec.Status::Application;
                        Rec.Modify;
                    end;
                end;
            }
            action(Close)
            {
                Caption = 'Close Need';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to close this need?', false) then begin
                        Rec.Status := Rec.Status::Closed;
                        Rec.Modify;
                    end;
                end;
            }
            action("Assign Training Participants")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Training participants";
                RunPageLink = "Training Need" = field(Code);
                Visible = Rec.Status <> Rec.Status::Closed;
            }
            action("Approved Training Participants")
            {
                Image = SocialSecurity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Approved Training Request List";
                RunPageLink = "Training Need" = FIELD(Code), Status = FILTER(Released);
                //RunPageMode = View;
            }
        }
    }
    var
        TrainingNeedsLines: Record "Training Needs Lines";
        TrainingNeed: Record "Training Need";
        Committment: Codeunit Committment;
        ErrorMsg: Text;
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        TrainingAmount: Decimal;
        GLEntry: Record "G/L Entry";
        GLBudgetEntry: Record "G/L Budget Entry";
        AccountNoFilter: Text;
        BudgetStartDate: Date;

    local procedure SetView()
    var
        GenLedSetup: Record "General Ledger Setup";
        GLAccount: Record "G/L Account";
        AccountNo: Code[20];
    begin
        AccountNoFilter := '';
        AccountNo := '';
        BudgetAmount := 0;
        Expenses := 0;
        BudgetAvailable := 0;
        GenLedSetup.Get;
        BudgetStartDate := GenLedSetup."Current Budget Start Date";
        TrainingNeedsLines.Reset;
        TrainingNeedsLines.SetCurrentKey("G/L Account");
        TrainingNeedsLines.SetRange("Document No.", Rec.Code);
        if TrainingNeedsLines.FindFirst then
            repeat
                if TrainingNeedsLines."G/L Account" <> '' then
                    if AccountNoFilter <> '' then begin
                        if TrainingNeedsLines."G/L Account" <> AccountNo then AccountNoFilter += '|' + TrainingNeedsLines."G/L Account";
                        AccountNo := TrainingNeedsLines."G/L Account";
                    end
                    else begin
                        AccountNoFilter := TrainingNeedsLines."G/L Account";
                        AccountNo := TrainingNeedsLines."G/L Account";
                    end;
            until TrainingNeedsLines.Next = 0;
        GLBudgetEntry.Reset;
        GLBudgetEntry.SetFilter("G/L Account No.", AccountNoFilter);
        GLBudgetEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
        GLBudgetEntry.SetRange(Date, BudgetStartDate, Today);
        if GLBudgetEntry.FindFirst then begin
            GLBudgetEntry.CalcSums(Amount);
            BudgetAmount := GLBudgetEntry.Amount;
        end;
        GLEntry.Reset;
        GLEntry.SetFilter("G/L Account No.", AccountNoFilter);
        GLEntry.SetRange("Dimension Set ID", Rec."Dimension Set ID");
        GLEntry.SetRange("Posting Date", BudgetStartDate, Today);
        if GLEntry.FindFirst then begin
            GLEntry.CalcSums(Amount);
            Expenses := GLEntry.Amount;
        end;
        BudgetAvailable := BudgetAmount - Expenses;
        // GLAccount.RESET;
        // GLAccount.SETFILTER(GLAccount."Budget Filter",GenLedSetup."Current Budget");
        // GLAccount.SETFILTER(GLAccount."No.",AccountNoFilter);
        // GLAccount.SETRANGE(GLAccount."Dimension Set ID Filter","Dimension Set ID");
        // GLAccount.SETRANGE(GLAccount."Date Filter",BudgetStartDate,TODAY);
        // IF GLAccount.FIND('-') THEN
        //  BEGIN
        //    GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change","Approved Budget","Disbursed Budget");
        //    BudgetAmount:=GLAccount."Approved Budget";
        //    Expenses:=GLAccount."Net Change";
        //    BudgetAvailable:=GLAccount."Approved Budget"-GLAccount."Net Change";
        //  END;
    end;
}

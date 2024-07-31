pageextension 50145 "Customer Card PageExt" extends "Customer Card"
{
    layout
    {
        modify("Partner Type")
        {
            Caption = 'Type';
            Visible = true;

            trigger OnAfterValidate()
            begin
                if Rec."Partner Type" = Rec."Partner Type"::Company then begin
                    Rec.TestField("Company Pin No.", Rec."Company Registration No.");
                end;
                if Rec."Partner Type" = Rec."Partner Type"::Person then begin
                    Rec.TestField("ID Number", Rec."Individual Pin Number");
                end;
            end;
        }
        addbefore(Name)
        {
            field(CustomerType; Rec.CustomerType)
            {
                Caption = 'Customer Type';
                Editable = StaffEditable;
                ApplicationArea = All;

                trigger Onvalidate()
                begin
                    SetCustomerView();
                end;
            }
            group(EmpNo)
            {
                ShowCaption = false;
                Visible = staff;
                Editable = StaffEditable;

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;

                    trigger Onvalidate()
                    begin
                        SetCustomerView();
                    end;
                }
            }
        }
        addlast(General)
        {
            field("Company Registration No."; Rec."Company Registration No.")
            {
                ApplicationArea = All;
            }
            field("Company Pin No."; Rec."Company Pin No.")
            {
                ApplicationArea = All;
            }
            field("ID Number"; Rec."ID Number")
            {
                ApplicationArea = All;
            }
            field("Individual Pin Number"; Rec."Individual Pin Number")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer Posting Group")
        {
            field("Petty Cash Posting Group"; Rec."Petty Cash Posting Group")
            {
                ApplicationArea = All;
            }
            field("Imprest Posting Group"; Rec."Imprest Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(PaymentRegistration)
        {
            action("Customer Branches")
            {
                Image = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = page "Customer Branches";
                RunPageLink = "customer No." = field("No.");
                ApplicationArea = All;
            }
            action("Send Receipt to Customer")
            {
                Caption = 'Mail Receipt';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ReceiptLines;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetFilter("No.", '%1', Rec."No.");
                    if Rec.FindFirst() then Report.Run(Report::"Email Customer Receipt", true, false, Rec);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetCustomerView();
    end;

    var
        Staff: Boolean;
        StaffEditable: Boolean;

    procedure SetCustomerView()
    begin
        if Rec.CustomerType = Rec.CustomerType::Staff then
            staff := true
        else
            staff := false;
        if Rec."Employee No." = '' then
            StaffEditable := true
        else
            StaffEditable := false;
    end;
}

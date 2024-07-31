page 50792 "Inspection Header"
{
    Caption = 'Inspection Header';
    PageType = Card;
    SourceTable = "Inspection Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Enabled = not Approved;

                field("Inspection No"; Rec."Inspection No")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Commitee Appointment No"; Rec."Commitee Appointment No")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Order No"; Rec."Order No")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Caption = 'Ref No';
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Inspection Date"; Rec."Inspection Date")
                {
                    ApplicationArea = All;
                }
            }
            part("Inspection Lines"; "Inspection Lines")
            {
                Enabled = not Approved;
                SubPageLink = "Inspection No" = field("Inspection No");
            }
            part("Committee Members"; "Committee Members")
            {
                Editable = false;
                SubPageLink = "Appointment No" = field("Commitee Appointment No");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Submitted")
            {
                Caption = '&Submit';
                Ellipsis = true;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Released;
                    ProcMgmt.SubmitInspectionDecision(Rec);
                    Rec.Modify();
                    CurrPage.Close();
                end;
            }
            action("Inspection Order")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    inspectionHeader: Record "Inspection Header";
                begin
                    inspectionHeader.Reset();
                    inspectionHeader.SetRange("Inspection No", Rec."Inspection No");
                    Report.Run(Report::"Inspection Order", true, false, inspectionHeader);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        Approved: Boolean;
        ProcMgmt: Codeunit "Procurement Management";

    procedure SetControlAppearance()
    var
    begin
        if Rec.Status = Rec.Status::Released then
            Approved := true
        else
            Approved := false;
    end;
}

page 50793 "Inspection Lines"
{
    Caption = 'Inspection Lines';
    PageType = ListPart;
    SourceTable = "Inspection Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No"; Rec."Item No")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Quantity Ordered"; Rec."Quantity Ordered")
                {
                    Enabled = false;
                }
                field("Inspection Decision"; Rec."Inspection Decision")
                {
                    ApplicationArea = All;

                    trigger OnVAlidate()
                    begin
                        SetControlAppearace();
                        CurrPage.Update();
                    end;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    Enabled = Accepted;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                    ApplicationArea = All;
                }
                field("Reasons for Rejection"; Rec."Reasons for Rejection")
                {
                    Enabled = Rejected;
                    ApplicationArea = All;
                }
                // field("Line No"; Rec."Line No")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }
    var
        Rejected: Boolean;
        Accepted: Boolean;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearace();
    end;

    procedure SetControlAppearace()
    var
        myInt: Integer;
    begin
        if Rec."Inspection Decision" = Rec."Inspection Decision"::Reject then
            Rejected := true
        else
            Rejected := false;
        if Rec."Inspection Decision" = Rec."Inspection Decision"::Accept then
            Accepted := true
        else
            Accepted := false;
    end;
}

page 51427 "External Committee Members"
{
    Caption = 'External Committee Members';
    PageType = ListPart;
    SourceTable = "Commitee Member";
    SourceTableView = where(External = const(true));
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                    ApplicationArea = All;
                }
                field(Role; Rec.Role)
                {
                    ToolTip = 'Specifies the value of the Role field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        CommitteeRec: Record "Tender Committees";

    trigger OnInsertRecord(BelowXrec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        GetHeader();
        Rec.External := true;
        Rec."Tender No." := CommitteeRec."Tender/Quotation No";
    end;

    trigger OnNewRecord(BelowXrec: Boolean)
    var
        myInt: Integer;
    begin
        GetHeader();
        Rec.External := true;
        Rec."Tender No." := CommitteeRec."Tender/Quotation No";
    end;

    local procedure GetHeader()
    begin
        if CommitteeRec.Get(Rec."Appointment No") then;
    end;
}

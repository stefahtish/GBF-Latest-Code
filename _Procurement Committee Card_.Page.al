page 51406 "Procurement Committee Card"
{
    Caption = 'Procurement Committee Card';
    PageType = Card;
    SourceTable = "Procurement Committees";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("Members "; Rec."Members")
                {
                    ToolTip = 'Specifies the value of the Members  field.';
                    ApplicationArea = All;
                }
                field(Permanent; Rec.Permanent)
                {
                    ToolTip = 'Specifies the value of the Permanent field.';
                    ApplicationArea = All;
                }
            }
            part("Committee Members"; "Committee Members")
            {
                ApplicationArea = all;
                SubPageLink = "Ref No" = FIELD("Code");
            }
        }
    }
}

page 50814 "Procurement Documents Sub Form"
{
    PageType = ListPart;
    SourceTable = "Document required";
    AutoSplitKey = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Code"; Rec."Document Code")
                {
                    ApplicationArea = all;
                }
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = all;
                }
                field(Checked; Rec.Checked)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Quote No"; Rec."Quote No")
                {
                    ApplicationArea = all;
                    Enabled = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}

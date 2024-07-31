page 51143 "Required Documents Setup"
{
    PageType = List;
    SourceTable = "Compliance Documents";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Process; Rec.Process)
                {
                }
                field("Registration Type"; Rec."Registration Type")
                {
                }
                field("License Category"; Rec."License Category")
                {
                }
                field(Document; Rec.Document)
                {
                }
            }
        }
    }
}

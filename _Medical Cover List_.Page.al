page 50482 "Medical Cover List"
{
    CardPageID = "Medical Scheme Header";
    PageType = List;
    SourceTable = "Medical Scheme Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Employee No"; Rec."Employee No")
                {
                }
                field("Employee Name"; Rec."Employee Name")
                {
                }
                field("Cover Type"; Rec."Cover Type")
                {
                }
                field("Name of Broker"; Rec."Name of Broker")
                {
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                }
                field("Policy Expiry Date"; Rec."Policy Expiry Date")
                {
                }
                field("No. Of Lives"; Rec."No. Of Lives")
                {
                }
                field("Fiscal Year"; Rec."Fiscal Year")
                {
                }
            }
        }
    }
    actions
    {
    }
}

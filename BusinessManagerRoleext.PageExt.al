pageextension 50159 BusinessManagerRoleext extends "Business Manager Role Center"
{
    actions
    {
        addafter("PaymentJournals")
        {
            group("Self Service")
            {
                group("Imprest Requisition")
                {
                    action(Imprest)
                    {
                        RunObject = Page "Imprests-General";
                        ApplicationArea = All;
                    }
                    action("Imprest Surrenders ")
                    {
                        RunObject = Page "Imprest Surrenders-General";
                        ApplicationArea = All;
                    }
                    action("Staff Claim List ")
                    {
                        RunObject = Page "Staff Claim List-General";
                        ApplicationArea = All;
                    }
                    action("Petty Cash")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Petty Cash List-General";
                    }
                    action("Petty Cash Surrenders")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Petty Cash Surrenders-Gen";
                    }
                }
            }
        }
    }
}
